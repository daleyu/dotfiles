# Herdr Navigator

This Stow package configures Herdr Navigator as the `prefix+T` picker. Ghostty's
`Alt+t` binding (and the macOS `Super+t` binding) sends that same Herdr key.

Install the plugin once on each machine with Herdr:

```sh
herdr plugin install thanhdat77/herdr-navigator --ref v0.3.6 --yes
```

Then stow this package from the dotfiles checkout and reload Herdr:

```sh
stow --target="$HOME" herdr
herdr server reload-config
```

Navigator's config enables the remote-target source. Add a `[[sessions.entries]]`
block in `~/.config/herdr/plugins/config/herdr-navigator/config.toml` for each
remote host you want listed. Each entry's `remote` value is passed to
`herdr --remote <target> --handoff` when selected. For example:

```toml
[[sessions.entries]]
name = "Build machine"
remote = "build-host"
tags = ["devbox"]
```

No saved Herdr machines or SSH host aliases were present when this was set up,
so the checked-in config leaves the target list empty until real host names are
added.
