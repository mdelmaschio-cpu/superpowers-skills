---
name: Hardening Linux Endpoints with CIS Benchmark
description: Harden Ubuntu/RHEL/CentOS endpoints against CIS Benchmark controls — filesystem, services, network, SSH, and audit logging — and verify compliance with OpenSCAP.
when_to_use: when deploying a new Linux server and establishing a security baseline; when remediating findings from a vulnerability scan or compliance audit (PCI DSS, HIPAA, SOC 2); when automating Linux hardening with Ansible, OpenSCAP, or shell scripts; when auditing SSH, sysctl, or auditd configuration against CIS controls
version: 1.0.0
languages: all
---

# Hardening Linux Endpoints with CIS Benchmark

## Overview

The CIS Benchmarks are the most widely adopted Linux hardening standard, organized into numbered sections (filesystem, services, network, access control, logging, file permissions). This skill walks through the high-value controls from each section and how to verify them with OpenSCAP, without requiring you to work through the full benchmark PDF line by line.

**Do not use for Windows** — see the Windows CIS hardening equivalent instead; the control IDs and tooling are unrelated.

## When to Use

- Hardening a new Ubuntu, RHEL, CentOS, or Debian server before it goes into production
- Remediating findings from a vulnerability scan or compliance audit
- Automating a Linux security baseline with Ansible, OpenSCAP, or shell scripts
- Meeting a specific compliance framework's technical control requirements on Linux

## Prerequisites

- Root or sudo access on the target endpoint
- The CIS Benchmark PDF for the target distribution (cisecurity.org, free registration)
- OpenSCAP (`openscap-scanner`, `scap-security-guide`) for automated assessment

## Workflow

### Step 1: Filesystem configuration

```bash
# Disable unused filesystem modules
cat >> /etc/modprobe.d/CIS.conf << 'EOF'
install cramfs /bin/true
install freevxfs /bin/true
install squashfs /bin/true
install udf /bin/true
EOF

# /dev/shm with nodev,nosuid,noexec
mount -o remount,nodev,nosuid,noexec /dev/shm
echo "tmpfs /dev/shm tmpfs defaults,nodev,nosuid,noexec 0 0" >> /etc/fstab
```

### Step 2: Services and network

```bash
# Disable services that aren't needed on a server
systemctl disable --now avahi-daemon cups rpcbind xinetd

# Harden kernel network parameters (host, not router)
cat >> /etc/sysctl.d/99-cis.conf << 'EOF'
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.tcp_syncookies = 1
EOF
sysctl --system

# Firewall default-deny — allow SSH *before* enabling, or you'll lock yourself out
ufw allow ssh
ufw default deny incoming
ufw default allow outgoing
ufw enable
```

### Step 3: SSH and access control

```bash
# /etc/ssh/sshd_config
cat >> /etc/ssh/sshd_config << 'EOF'
LogLevel VERBOSE
MaxAuthTries 4
PermitRootLogin no
PermitEmptyPasswords no
PasswordAuthentication no
X11Forwarding no
ClientAliveInterval 300
ClientAliveCountMax 3
EOF
systemctl restart sshd   # test from a SECOND session before closing the first
```

Password policy (`/etc/security/pwquality.conf`): `minlen = 14`, plus `dcredit`/`ucredit`/`ocredit`/`lcredit = -1` to require digit/upper/special/lower characters.

### Step 4: Audit logging

```bash
apt install auditd audispd-plugins -y
systemctl enable --now auditd

cat > /etc/audit/rules.d/cis.rules << 'EOF'
-w /etc/sudoers -p wa -k scope
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change
EOF
augenrules --load
```

### Step 5: Assess with OpenSCAP

```bash
apt install openscap-scanner scap-security-guide -y

oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_level1_server \
  --results /tmp/cis_results.xml \
  --report /tmp/cis_report.html \
  /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
```

The XCCDF results XML can be parsed programmatically (pass/fail counts, failed rule IDs) to feed a compliance dashboard or ticket queue.

## Key Concepts

| Term | Definition |
|---|---|
| **OpenSCAP** | Open-source SCAP scanner for automated compliance assessment |
| **auditd** | Linux audit framework for monitoring syscalls and file access |
| **sysctl** | Kernel parameter interface used for network/system security tuning |
| **AIDE** | File integrity checker — detects unauthorized changes to monitored files |

## Tools & Systems

- **OpenSCAP** — automated CIS benchmark assessment for Linux
- **Ansible Lockdown** — community Ansible roles for automated CIS remediation
- **Lynis** — open-source security auditing tool for Linux/Unix
- **auditd / AIDE** — syscall auditing and file integrity monitoring

## Common Pitfalls

- **Applying server benchmarks to workstations** — CIS publishes separate server/workstation profiles; the server profile disables desktop services you may actually need.
- **Breaking SSH access** — a sshd_config mistake (`PermitRootLogin`, `PasswordAuthentication`) can lock out every administrator at once. Always validate from a second, still-open session before closing the first.
- **Enabling the firewall default-deny before allowing SSH** — disconnects every remote session permanently; always `allow ssh` first.
- **Untested sysctl changes** — some kernel network parameters can break application networking; test in staging first.

## Included Script

`scripts/cis_audit.py` runs a live, read-only audit of the most common CIS Linux controls (filesystem modules, unnecessary services, network sysctl parameters, SSH config, auditd/rsyslog status, critical file permissions) directly against the host and prints a JSON findings report with a compliance score. Dependency-free (stdlib only). Run with `sudo python3 scripts/cis_audit.py`.

## Related Skills

- skills/security/triaging-security-incident-with-ir-playbook — when a hardening gap turns out to already be exploited
