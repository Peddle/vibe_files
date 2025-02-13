#!/usr/bin/env python3
import argparse
import os
import re
from urllib.parse import urlparse

from firecrawl import FirecrawlApp
from rich.console import Console
from rich.prompt import Prompt

console = Console()


def sanitize_url(url: str) -> str:
    parsed = urlparse(url)
    # Combine netloc and path, then remove unsafe characters
    dir_name = f"{parsed.netloc}{parsed.path}"
    safe = re.sub(r"[^\w\-]+", "_", dir_name).strip("_")
    return safe or "scraped_site"


def save_markdown_files(data: list, output_dir: str) -> None:
    for idx, page in enumerate(data, start=1):
        md_content = page.get("markdown")
        if not md_content:
            console.print(f":warning: Page {idx} has no markdown content, skipping...", style="yellow")
            continue
        title = page.get("metadata", {}).get("title")
        if title:
            safe_title = re.sub(r"[^\w\-]+", "_", title).strip("_")
        else:
            safe_title = f"page_{idx}"
        file_path = os.path.join(output_dir, f"{safe_title}.md")
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(md_content)
        console.print(f":sparkles: Saved [bold green]{file_path}[/]")


def main():
    parser = argparse.ArgumentParser(
        description="🚀 Crawl a URL using Firecrawl and save the markdown outputs."
    )
    parser.add_argument("url", help="The URL to crawl (e.g. https://example.com)")
    parser.add_argument(
        "--limit",
        type=int,
        default=100,
        help="Maximum number of pages to crawl (default: 100)",
    )
    args = parser.parse_args()

    api_key = os.environ.get("FIRECRAWL_API_KEY")
    if not api_key:
        console.print(":exclamation: Please set your FIRECRAWL_API_KEY environment variable.", style="bold red")
        return

    safe_dir = sanitize_url(args.url)
    output_dir = os.path.join(os.path.expanduser("~/Code/scraped_docs"), safe_dir)
    os.makedirs(output_dir, exist_ok=True)
    console.print(f":file_folder: Saving files to [bold blue]{output_dir}[/]")

    app = FirecrawlApp(api_key=api_key)
    params = {
        "limit": args.limit,
        "scrapeOptions": {"formats": ["markdown"]},
    }

    with console.status(":rocket: Crawling... Please wait...", spinner="dots"):
        try:
            result = app.crawl_url(args.url, params=params, poll_interval=10)
        except Exception as e:
            console.print(f":x: An error occurred during crawling: {e}", style="bold red")
            return

    if not result.get("success"):
        console.print(":x: Crawl was not successful!", style="bold red")
        return

    data = result.get("data", [])
    if not data:
        console.print(":warning: No data was returned from the crawl.", style="yellow")
        return

    save_markdown_files(data, output_dir)
    console.print(":tada: Crawl complete! Enjoy your freshly scraped markdown files!", style="bold green")


if __name__ == "__main__":
    main()
