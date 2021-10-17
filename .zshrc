# Path to your oh-my-zsh installation.
export ZSH=/Users/vladimir_burdukov/.oh-my-zsh

DEFAULT_USER="vladimir_burdukov"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  brew
  git
  osx
  xcode
  appcode
  fastlane
  z
  pod
  docker
  # github
  zsh-autosuggestions
  cargo
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl -w'
fi

alias ls='gls --color=auto'
alias zshconfig="code ~/.zshrc"
alias reload="source ~/.zshrc"
alias c='code'
alias s='subl'
alias ezio='ssh -t ezio "cd ~/web/; zsh"'
alias ds="docker-compose"
alias dsl="docker-compose logs -f"
alias dsps="docker-compose ps"
alias killsim="launchctl remove com.apple.CoreSimulator.CoreSimulatorService"
alias sm="smerge ."

if [[ -f ~/.dir_colors ]] ; then
    eval $(gdircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(gdircolors -b /etc/DIR_COLORS)
fi

export GPG_TTY

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/usr/local/opt/python/libexec/bin:/usr/local/sbin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
PATH="${HOME}/.iterm2${PATH:+:${PATH}}"; export PATH;

source $HOME/.cargo/env
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export CC_x86_64_unknown_linux_musl=x86_64-linux-musl-gcc
export CC_armv7_unknown_linux_gnueabihf=/Volumes/gcc/x-tools/arm-rpi3-linux-gnueabihf/bin/arm-rpi3-linux-gnueabihf-gcc

#export CURL_SSL_BACKEND=secure-transport

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
