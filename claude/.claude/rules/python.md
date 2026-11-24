---
paths:
  - "**/*.py"
  - "**/pyproject.toml"
---

# Python

- MUST use `uv` (`uv run`, `uv add`, `uv sync`); never bare `pip` or a global interpreter.
- MUST run `ruff check` and `ruff format --check` on changed files, and `pyright` when the project has config for it.
- MUST run tests with `uv run pytest -q` scoped to the affected path first; full suite only before a PR.
