# Sway Configuration Reference

Drop-in replacement for i3, running on Wayland.
Config file: `~/.config/sway/config`

---

## Addons

| Tool | Role | i3 equivalent | Config location |
|------|------|---------------|-----------------|
| **waybar** | Status bar | i3bar + i3status | `~/.config/waybar/config` and `~/.config/waybar/style.css` |
| **foot** | Terminal emulator | i3-sensible-terminal | `~/.config/foot/foot.ini` |
| **wofi** | App launcher | dmenu / rofi | `~/.config/wofi/config` and `~/.config/wofi/style.css` |
| **mako** | Notifications | dunst | `~/.config/mako/config` |
| **swaylock** | Screen locker | i3lock | CLI flags in `config` (see `exec swayidle`) |
| **swayidle** | Idle / DPMS management | xss-lock | Inline in `config` (`exec swayidle`) |
| **grim** | Screenshot capture | scrot / maim | No config; CLI only |
| **slurp** | Screen region selector | (none) | No config; CLI only |
| **wl-clipboard** | Clipboard (`wl-copy`/`wl-paste`) | xclip / xsel | No config |
| **brightnessctl** | Screen brightness | xbacklight | No config; CLI only — user must be in `video` group |
| **playerctl** | Media player control | (none) | No config; CLI only |
| **kanshi** | Multi-monitor profiles | arandr | `~/.config/kanshi/config` |
| **xdg-desktop-portal-wlr** | Screen sharing (e.g. Firefox, OBS) | (none) | `/etc/xdg/xdg-desktop-portal-wlr/config` |
| **policykit-1-gnome** | Privilege prompt dialogs | (none) | No config; runs as autostart daemon |
| **swaynag** | In-compositor warning dialogs | i3-nagbar | CLI only; invoked by exit binding |

### Install command

```bash
sudo apt install -y \
    wofi grim slurp wl-clipboard \
    brightnessctl playerctl kanshi \
    xdg-desktop-portal-wlr policykit-1-gnome
```

### Post-install steps

```bash
# Allow brightnessctl to work without sudo
sudo usermod -aG video $USER

# Create screenshots directory
mkdir -p ~/Pictures
```

---

## Keyboard Shortcuts

`$mod` = Super (Windows key)

### Session

| Shortcut | Action | Config line |
|----------|--------|-------------|
| `$mod + Shift + c` | Reload config | `bindsym $mod+Shift+c reload` |
| `$mod + Shift + r` | Reload config (i3 compat) | `bindsym $mod+Shift+r reload` |
| `$mod + Shift + e` | Exit sway (with confirmation) | `bindsym $mod+Shift+e exec swaynag ...` |

### Applications

| Shortcut | Action | Config line |
|----------|--------|-------------|
| `$mod + Return` | Open terminal (foot) | `bindsym $mod+Return exec $term` |
| `$mod + d` | Open app launcher (wofi run) | `bindsym $mod+d exec wofi --show run` |
| `$mod + Shift + d` | Open app launcher (wofi drun) | `bindsym $mod+Shift+d exec $menu` |

### Windows

| Shortcut | Action | Config line |
|----------|--------|-------------|
| `$mod + Shift + q` | Kill focused window | `bindsym $mod+Shift+q kill` |
| `$mod + h / j / k / l` | Focus left / down / up / right | `bindsym $mod+$left focus left` … |
| `$mod + Arrow keys` | Focus (same, arrow alternative) | `bindsym $mod+Left focus left` … |
| `$mod + Shift + h/j/k/l` | Move window left / down / up / right | `bindsym $mod+Shift+$left move left` … |
| `$mod + Shift + Arrows` | Move window (arrow alternative) | `bindsym $mod+Shift+Left move left` … |
| `$mod + f` | Toggle fullscreen | `bindsym $mod+f fullscreen toggle` |
| `$mod + Shift + Space` | Toggle floating | `bindsym $mod+Shift+space floating toggle` |
| `$mod + Space` | Toggle focus tiling/floating | `bindsym $mod+space focus mode_toggle` |
| `$mod + a` | Focus parent container | `bindsym $mod+a focus parent` |

### Layout

| Shortcut | Action | Config line |
|----------|--------|-------------|
| `$mod + b` | Split horizontal | `bindsym $mod+b splith` |
| `$mod + v` | Split vertical | `bindsym $mod+v splitv` |
| `$mod + s` | Stacking layout | `bindsym $mod+s layout stacking` |
| `$mod + w` | Tabbed layout | `bindsym $mod+w layout tabbed` |
| `$mod + e` | Toggle split layout | `bindsym $mod+e layout toggle split` |

> **Note:** i3 uses `$mod+h` for horizontal split, but that conflicts with vim-style navigation (`h` = left). This config uses `$mod+b` instead.

### Resize mode

Enter with `$mod + r`, exit with `Return` or `Escape`.

| Key | Action |
|-----|--------|
| `h` or `Left` | Shrink width |
| `l` or `Right` | Grow width |
| `j` or `Down` | Grow height |
| `k` or `Up` | Shrink height |

### Workspaces

| Shortcut | Action |
|----------|--------|
| `$mod + 1–9, 0` | Switch to workspace 1–10 |
| `$mod + Shift + 1–9, 0` | Move window to workspace 1–10 |

### Scratchpad

| Shortcut | Action | Config line |
|----------|--------|-------------|
| `$mod + Shift + -` | Send window to scratchpad | `bindsym $mod+Shift+minus move scratchpad` |
| `$mod + -` | Show / cycle scratchpad | `bindsym $mod+minus scratchpad show` |

### Screenshots

| Shortcut | Action | Output |
|----------|--------|--------|
| `Print` | Full screen | `~/Pictures/screenshot-YYYYMMDD-HHMMSS.png` |
| `$mod + Print` | Select region → file | `~/Pictures/screenshot-YYYYMMDD-HHMMSS.png` |
| `$mod + Shift + Print` | Select region → clipboard | (no file) |

### Media / Function keys

| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume -5% |
| `XF86AudioMute` | Mute toggle |
| `XF86AudioMicMute` | Mic mute toggle |
| `XF86MonBrightnessUp` | Brightness +5% |
| `XF86MonBrightnessDown` | Brightness -5% |
| `XF86AudioPlay` | Play / pause |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |

### Floating windows

Hold `$mod` and drag with the left mouse button to move.
Hold `$mod` and drag with the right mouse button to resize.

---

## Where to Configure Each Thing

### Wallpaper
Edit the `output` line in `~/.config/sway/config`:
```
output * bg ~/Pictures/wallpaper.jpg fill
# or: output * bg #1d2021 solid_color
```

### Status bar (waybar)
- Layout and modules: `~/.config/waybar/config`
- Colours and fonts: `~/.config/waybar/style.css`
- Restart after changes: `pkill waybar` — sway reloads it automatically via `exec_always`

### Notifications (mako)
`~/.config/mako/config` — example:
```ini
font=monospace 10
background-color=#285577
text-color=#ffffff
border-color=#4c7899
default-timeout=5000
```
Reload with: `makoctl reload`

### App launcher appearance (wofi)
- `~/.config/wofi/config` — sets flags like `width`, `height`, `prompt`
- `~/.config/wofi/style.css` — full GTK CSS theming

### Terminal (foot)
`~/.config/foot/foot.ini` — fonts, colours, scrollback, etc.
Docs: `man foot.ini`

### Screen lock (swaylock)
Flags are set inline in `~/.config/sway/config` inside the `exec swayidle` block:
```
'swaylock -f -c 000000'
```
Change `-c 000000` to set the lock screen colour, or add `--image ~/Pictures/lockscreen.jpg`.

### Idle timeouts (swayidle)
Edit the `exec swayidle` block in `~/.config/sway/config`:
```
timeout 300  'swaylock ...'      # lock after 5 min
timeout 600  'output dpms off'  # screen off after 10 min
```

### Multi-monitor layout (kanshi)
`~/.config/kanshi/config` — example:
```
profile laptop {
    output eDP-1 enable
}
profile docked {
    output eDP-1 disable
    output "Dell U2722D" enable position 0,0 mode 2560x1440@60Hz
}
```
Apply changes: `kanshictl reload`

### Keyboard layout / input options
Edit the `input type:keyboard` block in `~/.config/sway/config`:
```
input type:keyboard {
    xkb_layout us
    xkb_options caps:escape   # CapsLock → Escape
}
```
Find option names with: `grep -r caps /usr/share/X11/xkb/rules/base.lst`

### Touchpad
Uncomment and edit the `input type:touchpad` block in `~/.config/sway/config`.

### Gaps between windows
Uncomment in `~/.config/sway/config`:
```
gaps inner 6
gaps outer 4
```

### Window colours / borders
Edit the `client.*` lines and `default_border` in `~/.config/sway/config`.

### Autostart applications
Add `exec <command>` (runs once) or `exec_always <command>` (runs on every reload) in `~/.config/sway/config`.

---

## Useful Commands

```bash
# List all outputs and their names
swaymsg -t get_outputs

# List all inputs and their identifiers
swaymsg -t get_inputs

# Identify a window's app_id or class (for window rules)
swaymsg -t get_tree | grep -i app_id

# Lock screen immediately
swaylock -f -c 000000

# Reload config without restarting
swaymsg reload

# Capture screenshot manually
grim ~/Pictures/shot.png
grim -g "$(slurp)" ~/Pictures/region.png
```

---

## i3 vs Sway Differences

| Feature | i3 | Sway |
|---------|----|------|
| Display protocol | X11 | Wayland |
| Split horizontal | `$mod+h` | `$mod+b` (h is taken by vim nav) |
| Restart in place | `$mod+Shift+r` | Use reload (`$mod+Shift+c`) |
| Screen capture | scrot, maim | grim + slurp |
| Clipboard | xclip, xsel | wl-copy, wl-paste |
| Brightness | xbacklight | brightnessctl |
| Display config | xrandr / arandr | swaymsg output / kanshi |
| X11 apps | native | via XWayland (transparent) |
| Window criteria | `class`, `instance` | `app_id` (Wayland) or `class` (XWayland) |
