import argparse
import re
import sys
from pathlib import Path

try:
    from PyPDF2 import PdfReader
except ImportError:  # pragma: no cover
    try:
        from pypdf import PdfReader
    except ImportError:
        print("Install PyPDF2 or pypdf before using this script.", file=sys.stderr)
        raise


ROOT = Path(__file__).resolve().parents[1]
PDF_PATH = ROOT / "references" / "fedlex-rs-272-cpc-20260701-it.pdf"


def normalize(text: str) -> str:
    return re.sub(r"\s+", " ", text or "").strip()


def page_text(reader: PdfReader, page_index: int) -> str:
    try:
        return normalize(reader.pages[page_index].extract_text() or "")
    except Exception as exc:
        return f"[text extraction failed: {exc}]"


def article_patterns(article: str) -> list[re.Pattern[str]]:
    escaped = re.escape(article)
    return [
        re.compile(rf"\bArt\.\s*{escaped}\b", re.IGNORECASE),
    ]


def find_matches(reader: PdfReader, query: str | None, article: str | None, limit: int) -> list[tuple[int, str]]:
    results: list[tuple[int, str]] = []
    query_re = re.compile(re.escape(query), re.IGNORECASE) if query else None
    article_res = article_patterns(article) if article else []

    for i in range(len(reader.pages)):
        text = page_text(reader, i)
        matched = False
        if query_re and query_re.search(text):
            matched = True
        if article_res and any(pattern.search(text) for pattern in article_res):
            matched = True
        if matched:
            results.append((i + 1, text))
            if len(results) >= limit:
                break

    return results


def main() -> int:
    parser = argparse.ArgumentParser(description="Search the bundled Fedlex Swiss Code of Civil Procedure (CPC/RS 272) PDF.")
    parser.add_argument("--query", help="Keyword or phrase to search.")
    parser.add_argument("--article", help="CPC article number to search, e.g. 59 or 221.")
    parser.add_argument("--limit", type=int, default=8, help="Maximum matching pages to print.")
    args = parser.parse_args()

    if not args.query and not args.article:
        parser.error("Provide --query, --article, or both.")

    reader = PdfReader(str(PDF_PATH))
    matches = find_matches(reader, args.query, args.article, args.limit)

    print(f"PDF: {PDF_PATH}")
    print(f"Pages: {len(reader.pages)}")
    print(f"Matches: {len(matches)}")
    for page, text in matches:
        print("\n" + "=" * 80)
        print(f"PAGE {page}")
        print("=" * 80)
        print(text[:3500])

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
