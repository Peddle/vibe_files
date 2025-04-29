# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Lint/Test Commands

- Python scripts: `python3 scripts/<script_name>.py [arguments]`

## Code Style Guidelines

### Python
- Indentation: 4 spaces (PEP 8)
- Line length: 500 chars max
- Use Python type hints where appropriate
- Use f-strings for string formatting
- Error handling: Use try/except with specific exceptions
- Project structure: Use pyproject.toml for configuration

### Lua (Neovim)
- Indentation: 2 spaces
- Function style: Use local functions where possible
- Table style: Trailing commas in multiline tables
- Module pattern: Use return M pattern
- Error handling: Wrap pcall() around requires for optional plugins
- Plugins: Check existing plugins before suggesting new ones

### General
- Prefer snake_case for Python and camelCase for Lua identifiers
- Comment sections use -------- dividers
- Imports grouped by standard library, third-party, then local modules