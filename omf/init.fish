rvm default

alias ls='gls --color=auto'
alias git="gitext"
alias s='subl'
alias killsim="launchctl remove com.apple.CoreSimulator.CoreSimulatorService"
alias sm="smerge ."
alias ds="docker compose"

if test -e ~/.dir_colors
    eval (gdircolors -c ~/.dir_colors)
else if test -e /etc/DIR_COLORS
    eval (gdircolors -c /etc/DIR_COLORS)
end

if test -n "$SSH_CONNECTION"
    set -Ux EDITOR vim
else
    set -Ux EDITOR 'subl -w'
end

set -xg fish_cursor_default underscore
set -xg theme_color_scheme terminal
set -xg theme_nerd_fonts yes
set -xg theme_date_format "+%F %r"

set -xg GPG_TTY

set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8

fish_add_path -a "/opt/homebrew/sbin"
fish_add_path -a "$HOME/.cargo/bin"
fish_add_path -a "$HOME/.local/bin"
fish_add_path -a "$HOME/.usd/bin"
fish_add_path -a "$HOME/.mint/bin"

set -xg PYTHONPATH "/Users/Vladimir_Burdukov/.usd/lib/python"
set -xg RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/src"

set -xg SSH_AUTH_SOCK (launchctl getenv SSH_AUTH_SOCK)
