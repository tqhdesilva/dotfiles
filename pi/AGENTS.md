## Configuration

When configuring Codex settings, use CLI (`Codex config set` or `Codex mcp add`).
Config files: ~/.Codex.json for user settings, .Codex/settings.json for project settings.

## General Principles

Keep solutions minimal. Don't add extra features, keybinds, hooks, or complexity beyond what was asked for. When in doubt, do less.
Prefer existing CLI tools (e.g., task, qmd) over custom scripts and manual file manipulation.

## Writing Style

Never use the punctuation character named em dash in any output, file, or written content. Don't lazily substitute it with hyphens either. Restructure the sentence: use commas, semicolons, parentheses, or split it into separate sentences. Pick whichever option reads most naturally for the specific sentence.

## Python Package Management

Always use `uv` instead of `pip`. Use `uv add` for project dependencies, `uv pip install` for environment installs, and `uv pip install -r requirements.txt` instead of `pip install -r requirements.txt`.

## Secondbrain

You have a centralized knowledge base at `$SECONDBRAIN_VAULT`.
Use it to read and write context relevant to what you're working on.

**Reading:** Use `/secondbrain:query` for topic lookups. For known paths, read files directly from `$SECONDBRAIN_VAULT`.

**Writing:** When appropriate, ship context back using the appropriate skill (`/secondbrain:log`, `/secondbrain:til`, `/secondbrain:task`, etc.).

## Committing Code

Don't take any credit, or mention the commit is co-authored by Codex.

## Style

Be brief.

Always write math equations as LaTeX inlined into markdown (i.e. use `$` delimiters).
Examples:
Inline: $\int_{t = 0}^\infty x dx$

Block:

$$
\frac{1}{2 y}
$$
