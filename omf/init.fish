# rvm default

alias ls='gls --color=auto'
# alias git="gitext"
alias s='subl'
alias killsim="launchctl remove com.apple.CoreSimulator.CoreSimulatorService"
alias sm="smerge ."

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

set -xg theme_color_scheme terminal

set -xg GPG_TTY

set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8

fish_add_path -a "$HOME/.cargo/bin"
fish_add_path -a "$HOME/.bin"

# set -xg RUST_SRC_PATH "$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# set -xg DOCKER_HOST 'unix:///Users/vladimir_burdukov/.local/share/containers/podman/machine/qemu/podman.sock'
