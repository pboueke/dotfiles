# dotfiles

Personal development environment configuration for Linux (Wayland / Sway).

## Structure

```
dotfiles/
├── ansible/        # Ansible playbook for automated backup
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

## Installation

Clone and symlink each section:

```bash
git clone https://github.com/pboueke/dotfiles ~/Repositories/dotfiles
cd ~/Repositories/dotfiles

# Shell & prompt
ln -sf "$PWD/zsh/.zshrc"             ~/.zshrc
ln -sf "$PWD/starship/starship.toml" ~/.config/starship.toml

# Git
ln -sf "$PWD/git/.gitconfig"         ~/.gitconfig

# Neovim
ln -sf "$PWD/nvim"                   ~/.config/nvim

# Sway ecosystem
ln -sf "$PWD/sway"                   ~/.config/sway
ln -sf "$PWD/waybar"                 ~/.config/waybar
ln -sf "$PWD/wofi"                   ~/.config/wofi
ln -sf "$PWD/foot"                   ~/.config/foot
```

On first Neovim launch, [lazy.nvim](https://github.com/folke/lazy.nvim) will
bootstrap itself and install all plugins automatically.

---

## Ansible

**Directory:** `ansible/`

Ansible playbooks for managing this dotfiles repository. Requires only `ansible-core` and `rsync` — no extra collections needed.

```bash
sudo apt install ansible rsync
```

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
