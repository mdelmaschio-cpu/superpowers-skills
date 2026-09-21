---
name: Detecting FreeCAD MCP Drift
description: Detect and repair version drift between the freecad-mcp server and the FreeCADMCP addon installed in FreeCAD, which silently disables tools while ordinary work keeps succeeding.
when_to_use: when a FreeCAD MCP tool fails with 'method "X" is not supported' or an XML-RPC Fault; when get_rpc_status, get_async_status, or a timeout argument stops working; when execute_code_async launches but its result is unreachable; after freecad-mcp updates or FreeCAD is reinstalled; before trusting a FreeCAD MCP session for real modelling work; or when checking that the server half and the addon half are still the same version
version: 1.0.0
languages: [python]
allowed-tools:
  - Bash
  - Read
  - Write
---

# Detecting FreeCAD MCP Drift

FreeCAD MCP has **two independently versioned halves**. They can drift apart, and when they do, most work keeps succeeding — which is exactly what makes the drift dangerous.

| Half | Where it lives | How it updates |
|---|---|---|
| **Server** | `uvx freecad-mcp` (PyPI), configured in `claude_desktop_config.json` | Automatically to the newest release, unless the version is pinned |
| **Addon** | `<FreeCAD user dir>/Mod/FreeCADMCP/` | Manually. Usually a hand-copied directory with no `package.xml`, invisible to the Addon Manager |

An unpinned server keeps moving. The addon does not. The server is always the newer half.

## Why this is silent

The client ships compatibility fallbacks that mask the drift. The clearest example, from `freecad_client.py`:

```python
# Without an explicit timeout, call with a single argument so a
# newer client keeps working against an addon that predates the
# timeout parameter.
if timeout is None:
    return proxy.execute_code(code)
return proxy.execute_code(code, run_budget)
```

So `execute_code` without `timeout` works perfectly against an addon that cannot accept `timeout` at all. Modelling looks healthy. What is actually missing only shows up when you reach for the feature — often while debugging something else, which is the worst moment to discover the tool is gone.

**Do not conclude "the bridge works" from a successful `create_object` or `execute_code`.** Those exercise the oldest, most stable methods.

## The diagnostic signature

```
Failed to get RPC status: <Fault 1: '<class 'Exception'>:method "get_rpc_status" is not supported'>
```

Read this correctly:

- An XML-RPC **`Fault` is a reply from the addon** — the socket connected and the server answered. The bridge is UP. Do not report this as a connection failure or a missing MCP server.
- `method "X" is not supported` means **the addon is older than the server**. The server called a method the addon never implemented.

## Check both halves

```bash
# Server: which version is actually resolved
ls -d "$HOME/AppData/Local/uv/cache/archive-v0"/*/freecad_mcp-*.dist-info   # Windows
ls -d "$HOME/.cache/uv/archive-v0"/*/freecad_mcp-*.dist-info                # Linux/macOS

# Server: is it pinned?
python -c "import json,os;p=os.path.expanduser('~/AppData/Roaming/Claude/claude_desktop_config.json');print(json.load(open(p))['mcpServers']['freecad']['args'])"
```

Then, through the live MCP connection, ask the addon what it actually exposes:

```python
import sys, inspect
m = sys.modules.get("rpc_server.rpc_server")
print("loaded from:", getattr(m, "__file__", None))
for name in ("get_rpc_status", "get_async_status"):
    print(name, hasattr(m.FreeCADRPC, name))
print("execute_code:", inspect.signature(m.FreeCADRPC.execute_code))
```

`loaded from` is not a formality — see the `Mod/` trap below. Compare the result against the methods the server's `freecad_client.py` calls; every `proxy.<name>(` in that file is a method the addon must provide.

## Realigning

1. Find the upstream tag matching the server version exactly (`v0.1.24` for server `0.1.24`). The PyPI package does **not** ship the addon; it comes from the project repository under `addon/FreeCADMCP/`.
2. Download that tag and diff it against the installed copy **ignoring line endings** — a hand-installed addon is often CRLF while upstream is LF, which makes every line look changed:
   ```bash
   diff -q --strip-trailing-cr "$INSTALLED/rpc_server/settings.py" "$NEW/rpc_server/settings.py"
   ```
   User configuration lives in `freecad_mcp_settings.json` under the FreeCAD user dir, *not* inside the addon, so a wholesale replacement normally loses nothing. Verify that before overwriting rather than assuming it.
3. Back up the old addon **outside `Mod/`**.
4. Copy the new files in, then delete every `__pycache__` under the addon.
5. **Restart FreeCAD.**
6. Verify (below) before declaring success.

### Trap 1: never leave a backup inside `Mod/`

FreeCAD loads **every subdirectory of `Mod/`** as an addon. A backup at `Mod/FreeCADMCP.bak-<date>/` is not inert — it is a second addon defining the same `rpc_server` module, and it can win the import race and shadow the version you just installed.

The symptom is a restart that changes nothing, and it is deeply misleading: the files on disk are correct, the source greps clean, yet the running process still lacks the methods. The give-away is the `loaded from:` path pointing at the backup.

Put backups somewhere FreeCAD does not scan, e.g. `<FreeCAD user dir>/_mcp-addon-backups/`.

### Trap 2: restarting the RPC server is not enough

Stop/Start RPC Server from the MCP Addon workbench does **not** reload the Python modules — they stay in `sys.modules`, so the *old* class is simply re-registered. Only a full FreeCAD restart picks up new addon files.

Equally, do not try to restart the RPC server *through* the RPC connection: stopping the server closes the very channel the restart command would travel on.

## Verify the repair

Do not stop at the method that was failing. Check the whole contract:

| Check | Expected |
|---|---|
| `loaded from:` | the real `Mod/FreeCADMCP`, never a backup path |
| `get_rpc_status` | returns `rpc_server: running`, `gui_dispatch: healthy` |
| `get_async_status` | present |
| `inspect.signature(execute_code)` | includes the `timeout` parameter |
| a real call passing `timeout` | succeeds (exercises the 2-argument RPC path) |
| async round trip | `execute_code_async` → poll → `done` → result readable from the shared namespace |
| geometry regression | a known `Placement` round-trips with 0.000000000 mm bounding-box deviation |

The geometry regression matters: it proves the update changed the API surface without changing modelling behaviour. Build a box with a translation *and* a rotation, then compare FreeCAD's global bounding box against the analytically computed one. Translation alone will not catch a rotation-handling regression.

## Stop the drift recurring

Pin the server so both halves only move when you move them:

```json
"freecad": { "command": "uvx", "args": ["--system-certs", "freecad-mcp==0.1.24"] }
```

An unpinned `uvx freecad-mcp` re-drifts on the package's next release. When you do upgrade, upgrade **both halves in the same sitting** and re-run the verification table.

## Easy wrong turns

These are facts about this setup, not temptations to resist. Each one is sound
general reasoning that produces a confident wrong answer here.

| Looks reasonable | Why it is wrong here |
|---|---|
| "`create_object` worked, so the bridge is healthy" | That exercises the oldest methods. The client's fallbacks keep them working *because* of drift, not despite it. |
| "It returned a Fault, so the server is down" | A Fault *is* the server answering. The bridge is up; one method is missing. |
| "Keep the backup next to the addon, it's tidier" | `Mod/` is a load path, not storage. The backup becomes a competing addon and can win. |
| "Restart the RPC server to reload the files" | `sys.modules` keeps the old classes; the old one is simply re-registered. |
| "Every line of `settings.py` differs, so it is customised" | Diff with `--strip-trailing-cr` first. It is usually CRLF vs LF. |
| "Fix the one method that failed" | Methods go missing in cohorts. Enumerate the whole client contract. |
| "The files are updated on disk, so it is done" | Only `loaded from:` in the running process proves it. |

## Related

- `skills/cad/freecad-scripting` — FreeCAD Python API; covers a *different* drift (Draft/Arch naming across FreeCAD versions)
- `skills/cad/freecad-bim-modeling` — Draft/Arch/BIM and TechDraw workflows
