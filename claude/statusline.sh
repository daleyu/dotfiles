#!/bin/bash
# Claude Code status line — Catppuccin Mocha, lualine style
# Receives JSON session data on stdin, prints a single colored line.
# Requires jq, git, and a Nerd Font.
#
#   Left:  [MODE] [ branch +staged ~modified] project
#   Right:          [style] [agent] [context bar  % · $cost · time] [model]
#
#    INSERT   main  mimir             ━───────── 9% · $1.26 · 23m  Opus 5.5
#   └─blue──┘└─dark──┘└none─┘  (gap)  └──────── dark ─────────────┘└─blue──┘
#
#   MODE     vim mode (only when vim mode is on): INSERT blue, NORMAL mauve
#   branch   current git branch; +N staged files (green), ~N modified (yellow)
#   project  basename of workspace.project_dir (the dir Claude was started in)
#   bar / %  context window used; green < 50%, yellow < 80%, red after
#   $cost    estimated API-price cost of this session (not billed on Pro/Max)
#   time     wall-clock time since the session started
#   style    output style, only when not "default"
#   agent    only when started with --agent
#   model    active model, right-aligned using $COLUMNS (see RIGHT_MARGIN)
#
# Wired up via ~/dotfiles/claude/preferences.json (statusLine) and symlinked to
# ~/.claude/statusline.sh by agent-preferences-util.

input=$(cat)
export LC_ALL=C.UTF-8   # so ${#str} counts characters, not bytes

# Columns to leave free at the right edge so the line never wraps.
RIGHT_MARGIN=4

# ── Catppuccin Mocha (r;g;b) ────────────────────────────────────────────────
BLUE='137;180;250'   MAUVE='203;166;247'  PEACH='250;179;135'
GREEN='166;227;161'  YELLOW='249;226;175' RED='243;139;168'
TEAL='148;226;213'
TEXT='205;214;244'   SUBTEXT0='166;173;200' OVERLAY0='108;112;134'
SURFACE0='49;50;68'  MANTLE='24;24;37'    BASE='30;30;46'

E=$'\e'
fg() { REPLY="${E}[38;2;${1}m"; }
RESET="${E}[0m" BOLD="${E}[1m"

# Nerd Font glyphs
SEP_R=$''   # left-side separator (points right)
SEP_L=$''   # right-side separator (points left)
BRANCH=$''
ROBOT=$''

# ── Input ───────────────────────────────────────────────────────────────────
IFS=$'\x1f' read -r MODEL DIR PROJECT PCT COST VIM_MODE DURATION_MS STYLE AGENT < <(
  echo "$input" | jq -r '[
    (.model.display_name // "claude"),
    (.workspace.current_dir // .cwd // ""),
    (.workspace.project_dir // .workspace.current_dir // .cwd // ""),
    ((.context_window.used_percentage // 0) | floor | tostring),
    (.cost.total_cost_usd // 0 | tostring),
    (.vim.mode // ""),
    (.cost.total_duration_ms // 0 | tostring),
    (.output_style.name // "default"),
    (.agent.name // "")
  ] | join("\u001f")'
)
PROJECT="${PROJECT##*/}"

# ── Git status, cached so large repos don't lag the UI ─────────────────────
if command -v md5sum >/dev/null; then CACHE_KEY=$(printf '%s' "$DIR" | md5sum | cut -d' ' -f1)
else CACHE_KEY=$(printf '%s' "$DIR" | md5); fi
CACHE_FILE="/tmp/statusline-git-cache-${CACHE_KEY}"
CACHE_MAX_AGE=5  # seconds

mtime=$(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)
if [ $(( $(date +%s) - mtime )) -gt "$CACHE_MAX_AGE" ]; then
  if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
    printf '1|%s|%s|%s\n' \
      "$(git -C "$DIR" branch --show-current 2>/dev/null)" \
      "$(git -C "$DIR" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')" \
      "$(git -C "$DIR" diff --numstat 2>/dev/null | wc -l | tr -d ' ')" > "$CACHE_FILE"
  else
    printf '0|||\n' > "$CACHE_FILE"
  fi
fi
IFS='|' read -r IS_GIT BRANCH_NAME STAGED MODIFIED < "$CACHE_FILE"

# ── Segment builders ────────────────────────────────────────────────────────
# left  BG FG TEXT — appended left to right, joined by  arrows
# right BG FG TEXT — appended left to right, joined by  arrows
LEFT="" LBG=""
left() {
  if [ "$LBG" = "$1" ]; then LEFT+="${E}[38;2;${OVERLAY0}m${THIN_R}"
  elif [ -n "$LBG" ]; then LEFT+="${E}[38;2;${LBG}m${E}[48;2;${1}m${SEP_R}"; fi
  LEFT+="${E}[48;2;${1}m${E}[38;2;${2}m $3 "
  LBG="$1"
}
RIGHT="" RBG=""
right() {
  if [ "$RBG" = "$1" ]; then RIGHT+="${E}[38;2;${OVERLAY0}m${THIN_L}"
  else
    if [ -n "$RBG" ]; then RIGHT+="${E}[48;2;${RBG}m"; else RIGHT+="${E}[49m"; fi
    RIGHT+="${E}[38;2;${1}m${SEP_L}"
  fi
  RIGHT+="${E}[48;2;${1}m${E}[38;2;${2}m $3 "
  RBG="$1"
}

# ── Left side ───────────────────────────────────────────────────────────────
if [ -n "$VIM_MODE" ]; then
  case "$VIM_MODE" in
    INSERT) MODE_BG="$BLUE" ;;
    NORMAL) MODE_BG="$MAUVE" ;;
    *)      MODE_BG="$PEACH" ;;
  esac
  left "$MODE_BG" "$BASE" "${BOLD}${VIM_MODE}${E}[22m"
fi

if [ "${IS_GIT:-0}" = "1" ]; then
  GIT_TEXT="${BRANCH} ${BRANCH_NAME}"
  fg "$GREEN";  [ "${STAGED:-0}"   -gt 0 ] && GIT_TEXT+=" ${REPLY}+${STAGED}"
  fg "$YELLOW"; [ "${MODIFIED:-0}" -gt 0 ] && GIT_TEXT+=" ${REPLY}~${MODIFIED}"
  left "$SURFACE0" "$TEXT" "$GIT_TEXT"
fi

[ -n "$LBG" ] && LEFT+="${RESET}${E}[38;2;${LBG}m${SEP_R}"

# Project name — plain text on the terminal background, like lualine's filename
[ -n "$PROJECT" ] && LEFT+="${RESET}${E}[38;2;${TEXT}m ${PROJECT}"
LEFT+="$RESET"

# ── Right side ──────────────────────────────────────────────────────────────
[ -n "$STYLE" ] && [ "$STYLE" != "default" ] && right "$MANTLE" "$TEAL" "$STYLE"
[ -n "$AGENT" ] && right "$MANTLE" "$PEACH" "${ROBOT} ${AGENT}"

# Context fill: green < 50%, yellow < 80%, red after that
if   [ "$PCT" -ge 80 ]; then CTX="$RED"
elif [ "$PCT" -ge 50 ]; then CTX="$YELLOW"
else                         CTX="$GREEN"; fi
FILLED=$(( PCT * 10 / 100 )); EMPTY=$(( 10 - FILLED ))
BAR=""
fg "$CTX";      [ "$FILLED" -gt 0 ] && BAR+="${REPLY}$(printf "%${FILLED}s" | sed 's/ /━/g')"
fg "$OVERLAY0"; [ "$EMPTY"  -gt 0 ] && BAR+="${REPLY}$(printf "%${EMPTY}s"  | sed 's/ /─/g')"

COST_FMT=$(awk -v c="$COST" 'BEGIN { printf "$%.2f", c+0 }')
DURATION_FMT=$(awk -v ms="$DURATION_MS" 'BEGIN {
  s = int(ms / 1000); m = int(s / 60); h = int(m / 60)
  if (h > 0) printf "%dh%dm", h, m % 60; else printf "%dm", m }')

fg "$CTX"; CTX_FG="$REPLY"
fg "$SUBTEXT0"; DIM="$REPLY"
right "$SURFACE0" "$TEXT" "${BAR} ${CTX_FG}${PCT}%${DIM} · ${COST_FMT} · ${DURATION_FMT}"

right "$BLUE" "$BASE" "${BOLD}${MODEL}"
RIGHT+="$RESET"

# ── Join, right-aligning when the terminal width is known ──────────────────
strip() { REPLY=$(printf '%s' "$1" | sed "s/${E}\[[0-9;]*m//g"); }
GAP=" "
if [ "${COLUMNS:-0}" -gt 0 ]; then
  strip "$LEFT";  LW=${#REPLY}
  strip "$RIGHT"; RW=${#REPLY}
  PAD=$(( COLUMNS - LW - RW - RIGHT_MARGIN ))
  [ "$PAD" -gt 1 ] && GAP=$(printf "%${PAD}s" "")
fi

printf '%s\n' "${LEFT}${GAP}${RIGHT}"
