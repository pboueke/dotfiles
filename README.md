# dotfiles

Personal development environment configuration for Linux (Wayland / Sway).

## Structure

```
dotfiles/
├── ansible/        # Ansible playbooks (install, backup, check_deps)
├── foot/           # Terminal emulator (foot)
├── git/            # Git global configuration
├── nvim/           # Neovim (0.11+) Lua configuration
├── starship/       # Starship prompt theme
├── sway/           # Sway window manager + reference guide
├── waybar/         # Status bar (waybar)
├── wofi/           # App launcher (wofi)
├── zsh/            # Zsh shell configuration
├── nvim_hints.md   # Neovim plugin quickstart guide
└── LICENSE
```

## Ansible

**Directory:** `ansible/`

Ansible playbooks for managing this dotfiles repository. Requires only `ansible-core` and `rsync` — no extra collections needed.

```bash
sudo apt install ansible rsync
```

### install.yml

Deploys the dotfiles to the local user. The reverse of `backup.yml`: single files are copied with `ansible.builtin.copy` and directories are synced with `rsync`. Missing parent directories are created automatically.

**Usage:**

```bash
git clone https://github.com/pboueke/dotfiles ~/Repositories/dotfiles
ansible-playbook ~/Repositories/dotfiles/ansible/install.yml
```

**What gets deployed:**

| Repo | System |
|------|--------|
| `zsh/.zshrc` | `~/.zshrc` |
| `git/.gitconfig` | `~/.gitconfig` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `nvim/` | `~/.config/nvim/` |
| `sway/` | `~/.config/sway/` |
| `waybar/` | `~/.config/waybar/` |
| `wofi/` | `~/.config/wofi/` |
| `foot/` | `~/.config/foot/` |

A report is printed at the end. Files are marked `[COPIED]` (updated), `[OK]` (already current), or `[FAILED]`. Directories are marked `[SYNCED]` (N files updated), `[OK]` (up to date), or `[FAILED]`. Any directories that had to be created are listed in a separate section.

> On first Neovim launch, [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically.

### backup.yml

Copies the current configuration from the system into this repository. Handles single files with `ansible.builtin.copy` and directories with `rsync` (preserving permissions, deleting removed files).

**Usage:**

```bash
# Sync configs from system → repo (dry run friendly: inspect diff with git diff after)
ansible-playbook ansible/backup.yml

# Sync and automatically commit all changes with a timestamped message
ansible-playbook ansible/backup.yml -e auto_commit=true
```

**What gets synced:**

| Source (system) | Destination (repo) |
|-----------------|--------------------|
| `~/.zshrc` | `zsh/.zshrc` |
| `~/.gitconfig` | `git/.gitconfig` |
| `~/.config/starship.toml` | `starship/starship.toml` |
| `~/.config/nvim/` | `nvim/` |
| `~/.config/sway/` | `sway/` |
| `~/.config/waybar/` | `waybar/` |
| `~/.config/wofi/` | `wofi/` |
| `~/.config/foot/` | `foot/` |

The playbook can be run from any directory inside the repository — it resolves the repo root automatically via `playbook_dir`.

### check_deps.yml

Checks whether every tool required by this repository is present and (where applicable) meets the minimum version. Produces a report at the end listing OK / MISSING / OUTDATED for each item.

**Usage:**

```bash
ansible-playbook ansible/check_deps.yml
```

**What gets checked:**

| Category | Items |
|----------|-------|
| Core | `git`, `rsync` |
| Shell | `zsh`, `starship`, `oh-my-zsh`, `asdf` |
| Build | `make`, `gcc` (required by telescope-fzf-native) |
| Neovim | `nvim` ≥ 0.11, `vifm` |
| Sway ecosystem | `sway`, `waybar`, `wofi`, `foot`, `mako`, `swaylock`, `swayidle`, `grim`, `slurp`, `wl-copy`, `brightnessctl`, `playerctl`, `wpctl` |
| Fonts | FiraCode Nerd Font Mono |

For each missing item the report includes the `apt` package name or install URL.

---

## Shell — Zsh

**File:** `zsh/.zshrc` → `~/.zshrc`

- **Framework:** [Oh My Zsh](https://ohmyzsh.sh) with plugins `git` and `asdf`
- **Prompt:** [Starship](https://starship.rs) (see [Starship](#starship) section below)
- **Version manager:** [asdf](https://asdf-vm.com) for per-project language runtimes
- **Aliases:**

  | Alias       | Command                                     |
  |-------------|---------------------------------------------|
  | `ssedp1`    | Screenshot the `eDP-1` display via `grim`   |
  | `sshdmia2`  | Screenshot the `HDMI-A-2` display via `grim`|

**Dependencies:** `oh-my-zsh`, `starship`, `asdf`

> Oh My Zsh custom plugins/themes: none — only the built-in `git` and `asdf`
> plugins are used. The custom directory contains only oh-my-zsh scaffolding examples.

---

## Starship

**File:** `starship/starship.toml` → `~/.config/starship.toml`

[Starship](https://starship.rs) is a fast, cross-shell prompt written in Rust.

**Style:** Bracketed segments preset — all modules use the `\[content\]` format for a clean, unambiguous look that works with any font.

**Notable settings:**

| Module | Setting | Effect |
|--------|---------|--------|
| `cmd_duration` | `min_time = 0` | Shows execution time for every command, not just slow ones |
| `time` | `disabled = false` | Clock is always visible in the prompt |
| All language modules | Bracket format | Language version shown as `[python 3.x]` when in a matching project |

The theme activates language/tool modules contextually — e.g. `[py 3.13]` appears only when inside a Python project, `[node 20]` when inside a Node project, etc.

---

## Git

**File:** `git/.gitconfig` → `~/.gitconfig`

Useful aliases on top of the standard git CLI:

| Alias  | Expands to                                      |
|--------|-------------------------------------------------|
| `st`   | `status -s`                                     |
| `ci`   | `commit`                                        |
| `co`   | `checkout`                                      |
| `br`   | `branch`                                        |
| `cp`   | `cherry-pick`                                   |
| `cl`   | `clone`                                         |
| `dc`   | `diff --cached`                                 |
| `diff` | `diff --word-diff`                              |
| `ls`   | Formatted log with author, email, date, subject |
| `xl`   | `log --graph --decorate --all`                  |
| `t1`   | Compact graph log with relative dates           |
| `t2`   | Compact graph log with absolute dates           |
| `la`   | List all aliases                                |

---

## Sway

**Directory:** `sway/` → `~/.config/sway/`

[Sway](https://swaywm.org) is a Wayland compositor that is a drop-in replacement for i3.
Uses vim-style (`hjkl`) navigation and Super as the modifier key.

See **[sway/README.md](./sway/README.md)** for the full keybinding reference,
addon guide, and i3 migration notes.

### Addon ecosystem

| Tool | Config | Purpose |
|------|--------|---------|
| [waybar](https://github.com/Alexays/Waybar) | `waybar/` | Status bar (workspaces, clock, battery, volume, network…) |
| [wofi](https://hg.sr.ht/~scoopta/wofi) | `wofi/` | App launcher / run dialog |
| [foot](https://codeberg.org/dnkl/foot) | `foot/` | Terminal emulator |
| [mako](https://github.com/emersion/mako) | *(no config in repo)* | Notification daemon |
| [swaylock](https://github.com/swaywm/swaylock) | *(inline in sway/config)* | Screen locker |
| [swayidle](https://github.com/swaywm/swayidle) | *(inline in sway/config)* | Idle manager / DPMS |
| [grim](https://git.sr.ht/~emersion/grim) | *(no config)* | Screenshot capture |
| [slurp](https://github.com/emersion/slurp) | *(no config)* | Region selector for screenshots |
| [wl-clipboard](https://github.com/bugaevc/wl-clipboard) | *(no config)* | Wayland clipboard (`wl-copy` / `wl-paste`) |
| [brightnessctl](https://github.com/Hummer12007/brightnessctl) | *(no config)* | Backlight control |
| [playerctl](https://github.com/altdesktop/playerctl) | *(no config)* | Media player control keys |
| [wpctl](https://pipewire.pages.freedesktop.org/wireplumber/) | *(no config)* | PipeWire/WirePlumber volume control |

Install addons:
```bash
sudo apt install -y \
    waybar wofi foot mako swaylock swayidle \
    grim slurp wl-clipboard brightnessctl playerctl

# Allow brightness control without sudo
sudo usermod -aG video $USER
```

### Key sway bindings (summary)

`$mod` = Super key

| Shortcut | Action |
|----------|--------|
| `$mod+Return` | Open terminal (foot) |
| `$mod+d` / `$mod+Shift+d` | Launch app (wofi run / drun) |
| `$mod+Shift+q` | Kill window |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+1–0` | Switch workspace |
| `$mod+Shift+1–0` | Move window to workspace |
| `$mod+f` | Fullscreen |
| `$mod+Shift+Space` | Toggle floating |
| `$mod+b` / `$mod+v` | Split horizontal / vertical |
| `$mod+r` | Resize mode |
| `$mod+-` / `$mod+Shift+-` | Scratchpad show / send |
| `$mod+Shift+c` | Reload config |
| `$mod+Shift+e` | Exit sway |
| `Print` | Screenshot to file |
| `$mod+Print` | Screenshot region to file |
| `$mod+Shift+Print` | Screenshot region to clipboard |

---

## Waybar

**Directory:** `waybar/` → `~/.config/waybar/`

Monospace text-only bar with a gruvbox-inspired colour scheme.

**Left:** workspaces · mode indicator · scratchpad count
**Centre:** active window title
**Right:** idle inhibitor · volume · network · CPU · memory · temperature · brightness · battery · keyboard state · clock · tray

Waybar is started by sway via `exec_always sh -c 'pkill -x waybar; waybar'`
so it restarts automatically on `$mod+Shift+c` reload.

---

## Wofi

**Directory:** `wofi/` → `~/.config/wofi/`

Minimal GTK app launcher. Configured for `drun` mode (desktop entries) with 480×320px window, monospace font, case-insensitive search, and icons.

---

## Foot

**Directory:** `foot/` → `~/.config/foot/`

Fast, Wayland-native terminal emulator.

| Setting | Value |
|---------|-------|
| Shell | `/usr/bin/zsh` (login shell) |
| Font | FiraCode Nerd Font Mono 11pt |
| Font size up | `Ctrl++` / `Ctrl+=` |
| Font size down | `Ctrl+-` |

---

## Neovim

**Directory:** `nvim/` → `~/.config/nvim/`

Full Lua-based configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager. Requires **Neovim 0.11+**.

### Directory layout

```
nvim/
├── init.lua                    entry point: loads config, bootstraps lazy.nvim
└── lua/
    ├── config/
    │   ├── options.lua         vim options (numbers, indentation, clipboard, mouse…)
    │   ├── keymaps.lua         leader key (Space) + base window/search mappings
    │   └── lazy.lua            lazy.nvim bootstrap + plugin loader
    └── plugins/
        ├── colorscheme.lua     tokyonight (night style)
        ├── telescope.lua       fuzzy finder for files, grep, buffers, help
        ├── treesitter.lua      syntax tree parsing, highlighting, indentation
        ├── lsp.lua             Mason + mason-lspconfig + nvim-lspconfig
        ├── completion.lua      nvim-cmp + LuaSnip + buffer/path/LSP sources
        ├── editor.lua          Comment.nvim + nvim-surround + Grapple
        ├── git.lua             vim-fugitive + gitsigns
        ├── files.lua           vifm file manager integration
        └── syntax.lua          vim-polyglot (syntax for 600+ languages)
```

### Plugins

| Plugin | Purpose |
|--------|---------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax parsing, highlighting, indentation |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP / linter / formatter binary installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridges Mason with Neovim's built-in LSP |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Server config data source (cmd, filetypes, root_dir) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | Toggle comments (`gcc`, `gc`) |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding chars |
| [grapple.nvim](https://github.com/cbochs/grapple.nvim) | File tagging and instant navigation |
| [vifm.vim](https://github.com/vifm/vifm.vim) | vifm file manager inside Neovim |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Full Git porcelain inside Neovim |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git diff signs, per-hunk staging, inline blame |
| [vim-polyglot](https://github.com/sheerun/vim-polyglot) | Syntax + indent for 600+ languages |

### LSP — adding a language server

```vim
:MasonInstall pyright        " Python
:MasonInstall ts_ls          " TypeScript / JavaScript
:MasonInstall rust_analyzer  " Rust
:MasonInstall gopls          " Go
:MasonInstall clangd         " C / C++
```

### Quickstart guide

See **[nvim_hints.md](./nvim_hints.md)** for the full plugin quickstart covering
every plugin's keymaps, commands, and workflows.
