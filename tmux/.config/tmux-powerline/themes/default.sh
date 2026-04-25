# Load built-in default theme
source "${TMUX_POWERLINE_DIR_HOME}/themes/default.sh"

# Highlight windows with a pending bell in yellow
TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
	"#[$(tp_format regular)]"
	"#{?window_bell_flag,#[fg=yellow],}"
	"  #I#{?window_flags,#F, } "
	"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
	" #W "
)
