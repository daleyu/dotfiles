# Claude preferences

Portable preferences are stored in preferences.json.
The active config is a separate local file, not a symlink.

Apply shared preferences from the dotfiles root (Python 3.11+):

```sh
agent-preferences-util
```

After changing preferences inside the apps, save allowed preferences back:

```sh
agent-preferences-util --capture
```

Capture uses an explicit allowlist. Models, themes, Vim settings, and
keybindings can be shared; trust, permission settings, hooks, session state,
and other unlisted settings remain local. Review git diff before publishing.
Claude shortcuts use an optional claude/keybindings.json file;
Codex shortcuts are under tui.keymap in codex/preferences.toml.

Linux and macOS installers apply preferences automatically. Do not stow
the codex or claude directories. Application changes are captured only when
you explicitly run --capture. Applying preferences preserves local settings
but normalizes config formatting; a .before-preferences backup is kept locally.

The status line lives in claude/statusline.sh (Catppuccin Mocha powerline;
needs jq, git, and a Nerd Font). Applying preferences symlinks it to
~/.claude/statusline.sh, so edits here take effect immediately.
