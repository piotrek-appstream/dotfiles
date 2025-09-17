# Repository Guidelines

## Project Structure & Module Organization
This repo houses personal dotfiles managed via GNU Stow. Top-level directories such as `git` and `nvim` mirror the desired targets in `$HOME`; apply them with Stow instead of copying by hand. Neovim sources live in `nvim/.config/nvim`, with entrypoint `init.lua` delegating into `lua/config` (core settings) and `lua/plugins` (one plugin spec per file). Shared assets like `lazy-lock.json` pin plugin versions—update it only when intentionally upgrading dependencies.

## Build, Test, and Development Commands
Use `stow git` or `stow nvim` from the repo root to symlink configs into your home directory; add `-D` to detach a module. After updating Neovim plugins, run `nvim --headless "+Lazy sync" +qa` to install or prune packages. Format Lua before committing with `stylua lua/**/*.lua`. When touching lockfiles, confirm determinism by re-running `nvim --headless "+Lazy lock" +qa`.

## Coding Style & Naming Conventions
Follow the Stylua settings in `nvim/.config/nvim/stylua.toml`: spaces only, width 2, max line length 120. Module filenames under `lua/plugins` should stay kebab-case (e.g., `noice.lua`) or follow the plugin slug (`blink.cmp.lua`). Prefer descriptive snake_case locals and keep plugin opts in dedicated tables so updates remain diff-friendly. Avoid embedding secrets—reference environment variables instead.

## Testing Guidelines
There is no automated test suite, so validate changes manually. Run `nvim --headless "+Lazy health" +qa` to catch startup errors and plugin misconfiguration. If you alter autocommands or mappings, open Neovim interactively and exercise the affected workflow. For shell-related tweaks, confirm the resulting symlinks resolve correctly in `$HOME`.

## Commit & Pull Request Guidelines
Commits in this repo use concise, sentence-case subjects (see `git log --oneline`). Write the subject in the imperative mood, keep it under ~72 characters, and group related adjustments together. Pull requests should include a short what/why, list any manual verification steps (commands run, editors launched), and link relevant issues or screenshots when UI behaviour changes.

## Security & Configuration Tips
Never commit machine-specific secrets or tokens; use `.local` overrides outside the repo. Before pushing, double-check that added Stow targets exist on all supported machines to avoid broken symlinks during bootstrap.
