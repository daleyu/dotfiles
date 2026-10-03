# Spicetify: Catppuccin Mocha

```bash
yay -S spicetify-cli
```


```bash
stow --target="$HOME" spicetify
spicetify config spotify_path "$HOME/.local/share/spotify-launcher/install/usr/share/spotify"
spicetify config current_theme catppuccin color_scheme mocha
spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
spicetify apply
```
