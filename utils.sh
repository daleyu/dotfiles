# util script for download and stowing

install_herdr() {
  if ! command -v herdr >/dev/null 2>&1; then
    echo "install_herdr: herdr is not on PATH" >&2
    return 1
  fi

  herdr plugin install thanhdat77/herdr-navigator --ref v0.3.6 --yes || return
  herdr plugin install salkhalil/herdr-sessionizer --yes || return
  herdr plugin install beyondlex/herdr-recent-navigator --yes || return

  if herdr status server >/dev/null 2>&1; then
    herdr server reload-config
  else
    echo "Herdr is not running; installed plugins will load when it starts."
  fi
}
