# Neovim Plugin Quickstart Guide

Leader key is `<Space>`.

---

## Table of Contents
1. [Telescope](#telescope)
2. [Treesitter](#treesitter)
3. [LSP (lspconfig + Mason)](#lsp)
4. [nvim-cmp (Completion)](#nvim-cmp)
5. [Comment.nvim](#commentnvim)
6. [Grapple](#grapple)
7. [Oil](#oil)
8. [nvim-surround](#nvim-surround)
9. [Fugitive](#fugitive)
10. [Polyglot](#polyglot)
11. [Gitsigns](#gitsigns)

---

## Telescope

**What it does:** Fuzzy finder for files, text, buffers, help, diagnostics, and more.

### Key mappings
| Key           | Action                     |
|---------------|----------------------------|
| `<leader>ff`  | Find files in project      |
| `<leader>fg`  | Live grep (search text)    |
| `<leader>fb`  | Open buffers               |
| `<leader>fh`  | Search help tags           |
| `<leader>fr`  | Recent files               |
| `<leader>fd`  | Workspace diagnostics      |

### Inside the picker
| Key        | Action                  |
|------------|-------------------------|
| `<C-j>`    | Move selection down     |
| `<C-k>`    | Move selection up       |
| `<Enter>`  | Open selected           |
| `<C-x>`    | Open in horizontal split|
| `<C-v>`    | Open in vertical split  |
| `<C-t>`    | Open in new tab         |
| `<Esc>`    | Close picker            |

### Tips
- Use `<leader>fg` then type a word to search across all project files.
- Inside the results list, press `<Tab>` to multi-select files.
- `:Telescope` (tab) lists all available pickers.

---

## Treesitter

**What it does:** Parses source code into a syntax tree for accurate highlighting, indentation, and text objects. Works automatically on supported file types.

### Commands
| Command                    | Action                              |
|----------------------------|-------------------------------------|
| `:TSInstall <lang>`        | Install parser for a language       |
| `:TSUpdate`                | Update all installed parsers        |
| `:TSBufToggle highlight`   | Toggle highlighting for buffer      |
| `:InspectTree`             | View the parsed syntax tree         |

### Configured languages
Lua, Vim, Bash, JavaScript, TypeScript, Python, JSON, YAML, TOML, Markdown, HTML, CSS. Additional parsers are auto-installed when you open a supported file.

### Tips
- If highlighting looks wrong, try `:TSBufToggle highlight` to toggle.
- Treesitter powers smarter indentation — if auto-indent misbehaves for a language, check `:TSInstall <lang>`.

---

## LSP

**What it does:** Language Server Protocol integration. Provides diagnostics, go-to-definition, completions, hover docs, and refactoring for any language with a server.

**Architecture (Neovim 0.11+):** Neovim now has a built-in LSP config system. `nvim-lspconfig` acts as a data source (server commands, filetypes, root detection), Mason installs the binaries, and `mason-lspconfig` calls `vim.lsp.enable()` for each installed server automatically.

### Mason commands (server installer)
| Command                        | Action                              |
|--------------------------------|-------------------------------------|
| `:Mason`                       | Open Mason UI                       |
| `:MasonInstall <server>`       | Install an LSP server               |
| `:MasonUninstall <server>`     | Remove an LSP server                |
| `:MasonUpdate`                 | Update installed servers            |

**Example servers:** `pyright` (Python), `ts_ls` (TypeScript/JS), `rust_analyzer`, `gopls`, `clangd`, `lua_ls` (pre-installed).

### LSP keymaps (active when LSP attaches to a buffer)
| Key           | Action                     |
|---------------|----------------------------|
| `gd`          | Go to definition           |
| `gD`          | Go to declaration          |
| `gr`          | List references            |
| `gi`          | Go to implementation       |
| `K`           | Hover documentation        |
| `<leader>rn`  | Rename symbol              |
| `<leader>ca`  | Code action                |
| `<leader>d`   | Show line diagnostics      |
| `[d`          | Jump to previous diagnostic|
| `]d`          | Jump to next diagnostic    |

### Tips
- Install a server: `:MasonInstall pyright`, then reopen any `.py` file.
- Check LSP status for the current buffer: `:LspInfo`.
- Format the current buffer: `:lua vim.lsp.buf.format()` (if the server supports it).
- To override settings for one server, add a file `~/.config/nvim/lsp/<server>.lua`:
  ```lua
  -- Example: ~/.config/nvim/lsp/lua_ls.lua
  return {
    settings = { Lua = { diagnostics = { globals = { "vim" } } } }
  }
  ```

---

## nvim-cmp

**What it does:** Completion engine. Shows suggestions from LSP, open buffers, file paths, and snippets as you type.

### Insert-mode mappings
| Key          | Action                            |
|--------------|-----------------------------------|
| `<C-Space>`  | Trigger completion manually       |
| `<C-j>`      | Select next item                  |
| `<C-k>`      | Select previous item              |
| `<Tab>`      | Next item / expand/jump snippet   |
| `<S-Tab>`    | Previous item / jump back snippet |
| `<CR>`       | Confirm selection                 |
| `<C-e>`      | Dismiss completion menu           |

### Completion sources (priority order)
1. LSP — symbols from the attached language server
2. LuaSnip — snippets
3. Buffer — words in open buffers
4. Path — filesystem paths

### Tips
- `<CR>` with `select = false` means pressing Enter on a blank selection won't accidentally insert a completion — you must explicitly move to an item first.
- To add more sources, install the relevant `cmp-*` plugin and add `{ name = "..." }` to the sources list in `lua/plugins/completion.lua`.

---

## Comment.nvim

**What it does:** Toggle line and block comments with a single key. Lua-native replacement for `tpope/vim-commentary`. Supports tree-sitter context-aware commenting (e.g., JSX inside TSX files).

### Normal mode
| Key    | Action                              |
|--------|-------------------------------------|
| `gcc`  | Toggle comment on current line      |
| `gbc`  | Toggle block comment on current line|
| `gc{motion}` | Comment over a motion (e.g. `gcip` = comment paragraph) |

### Visual mode
| Key  | Action                          |
|------|---------------------------------|
| `gc` | Toggle line comment on selection|
| `gb` | Toggle block comment on selection|

### Tips
- `gcG` comments from current line to end of file.
- `gc5j` comments the next 5 lines.

---

## Grapple

**What it does:** Pin ("tag") up to 4 files per project and jump between them instantly — similar to Harpoon. Tags persist across sessions.

### Key mappings
| Key          | Action                           |
|--------------|----------------------------------|
| `<leader>a`  | Tag / untag current file         |
| `<leader>e`  | Open tags window                 |
| `<leader>1`  | Jump to tagged file #1           |
| `<leader>2`  | Jump to tagged file #2           |
| `<leader>3`  | Jump to tagged file #3           |
| `<leader>4`  | Jump to tagged file #4           |

### Inside the tags window
| Key      | Action                         |
|----------|--------------------------------|
| `<Enter>`| Jump to file under cursor      |
| `d`      | Remove tag under cursor        |
| `q`/`<Esc>` | Close window                |

### Workflow
1. Open a frequently-used file, press `<leader>a` to tag it.
2. Open other files you need and tag them too (up to 4).
3. Use `<leader>1`–`<leader>4` to jump between them without searching.
4. Press `<leader>e` to see and reorder your tagged files.

---

## Oil

**What it does:** Edit the filesystem like a buffer. Navigate directories, rename, move, create, and delete files using normal Neovim motions. No system dependencies required.

### Key mappings
| Key          | Action                                  |
|--------------|-----------------------------------------|
| `-`          | Open parent directory of current file   |
| `<leader>vv` | Open parent directory (current window)  |
| `<leader>vV` | Open parent directory (floating window) |

### Inside the oil buffer
| Key         | Action                              |
|-------------|-------------------------------------|
| `<Enter>`   | Open file / enter directory         |
| `-`         | Go up to parent directory           |
| `_`         | Open the current working directory  |
| `<C-s>`     | Open file in horizontal split       |
| `<C-v>`     | Open file in vertical split         |
| `<C-t>`     | Open file in new tab                |
| `<C-h>`     | Toggle hidden files                 |
| `<C-r>`     | Refresh directory listing           |
| `g?`        | Show help                           |
| `q`         | Close oil buffer                    |

### Editing the filesystem
Oil buffers are editable. To rename, move, create, or delete:
1. Make changes directly in the buffer (rename a line, delete a line, duplicate a line)
2. Save with `:w` — oil applies the changes to disk

### Tips
- Press `-` from any buffer to instantly browse its directory.
- Deleting a line in the buffer and saving deletes the file from disk.
- Moving a line between two open oil buffers and saving moves the file.

---

## nvim-surround

**What it does:** Add, change, or delete surrounding characters (quotes, brackets, tags, etc.). Lua-native replacement for `tpope/vim-surround`.

### Operations
| Key             | Action                                      |
|-----------------|---------------------------------------------|
| `ys{motion}{char}` | **Add** surround around motion           |
| `ds{char}`      | **Delete** surrounding char               |
| `cs{old}{new}`  | **Change** surrounding char               |
| `S{char}`       | **Add** surround around visual selection  |

### Examples
```
ysw"        wrap word in double quotes:  word  →  "word"
ysiw(       wrap word in parens:         word  →  ( word )
ysiw)       wrap word in parens (tight): word  →  (word)
yss)        wrap entire line in parens
ds"         delete surrounding quotes:  "word" →  word
cs"'        change quotes:              "word" →  'word'
cs({        change parens to braces:    (word) →  {word}
dst         delete surrounding HTML tag
cst<div>    change surrounding tag to <div>
```

### Visual mode
Select text, then press `S` followed by the surrounding character.

---

## Fugitive

**What it does:** A full Git porcelain inside Neovim. Run any git command via `:Git <cmd>`, with interactive staging, diffing, and log browsing.

### Key mappings
| Key          | Action              |
|--------------|---------------------|
| `<leader>gs` | Git status (`:Git`) |
| `<leader>gd` | Git diff split      |
| `<leader>gb` | Git blame           |
| `<leader>gl` | Git log             |

### Essential commands
| Command             | Action                              |
|---------------------|-------------------------------------|
| `:Git`              | Status window (interactive)         |
| `:Git add %`        | Stage current file                  |
| `:Git commit`       | Commit (opens commit message buffer)|
| `:Git push`         | Push                                |
| `:Git pull`         | Pull                                |
| `:Gdiffsplit`       | Diff current file against HEAD      |
| `:Gdiffsplit HEAD~1`| Diff against specific commit        |
| `:Gread`            | Revert file to HEAD version         |
| `:Gclog`            | Browse commit log for current file  |
| `:Git log --oneline`| Compact log                         |

### Inside the :Git status window
| Key   | Action                              |
|-------|-------------------------------------|
| `s`   | Stage file / hunk under cursor      |
| `u`   | Unstage file / hunk                 |
| `=`   | Toggle inline diff for file         |
| `dv`  | Diff in vertical split              |
| `cc`  | Create commit                       |
| `ca`  | Amend last commit                   |
| `q`   | Close window                        |

---

## Polyglot

**What it does:** Provides syntax highlighting and indent rules for 600+ languages, filling gaps not yet covered by Treesitter. Loads automatically — no keymaps needed.

### Disabling for specific languages
If a language's highlighting looks wrong (conflict with Treesitter), disable polyglot for it in `lua/plugins/syntax.lua`:

```lua
vim.g.polyglot_disabled = { "sensible", "python", "javascript" }
```

This must be set before the plugin loads (in the `init` function, already wired up).

### Notes
- Polyglot and Treesitter coexist: Treesitter takes precedence when its parser is active.
- Useful for niche languages (Pug, TOML variants, templating engines) that Treesitter may not cover.

---

## Gitsigns

**What it does:** Shows git diff decorations in the sign column (added/changed/deleted lines), enables per-hunk staging, and inline blame.

### Key mappings
| Key           | Action                         |
|---------------|--------------------------------|
| `]c`          | Jump to next hunk              |
| `[c`          | Jump to previous hunk          |
| `<leader>hs`  | Stage hunk                     |
| `<leader>hr`  | Reset hunk                     |
| `<leader>hS`  | Stage entire buffer            |
| `<leader>hu`  | Undo last staged hunk          |
| `<leader>hp`  | Preview hunk (floating window) |
| `<leader>hb`  | Blame current line (full info) |
| `<leader>hd`  | Diff this file against HEAD    |

Visual mode: select lines, then `<leader>hs` / `<leader>hr` to stage/reset just those lines.

### Sign column legend
| Sign | Meaning          |
|------|------------------|
| `│`  | Changed line     |
| `+`  | Added line(s)    |
| `_`  | Deleted below    |
| `‾`  | Deleted above    |

### Tips
- `<leader>hp` is great for reviewing a change before staging it.
- Use Gitsigns for hunk-level staging; use Fugitive's `:Git` for a full status/commit workflow.
- `:Gitsigns toggle_signs` toggles the sign column decorations.

---

## Leader Key Reference

```
<leader>f*   Telescope finders
<leader>g*   Git (Fugitive)
<leader>h*   Git hunks (Gitsigns)
<leader>v*   Oil file manager
<leader>1-4  Grapple file jumps
<leader>a    Grapple tag/untag
<leader>e    Grapple tags window
<leader>rn   LSP rename
<leader>ca   LSP code action
<leader>d    LSP diagnostics (float)
[d / ]d      LSP prev/next diagnostic
```
