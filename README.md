# quick start

## this repo

```shell
xcode-select --install
git clone https://github.com/chipp/dotfiles $TMPDIR/dotfiles
```

## [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp $TMPDIR/dotfiles/.zshrc ~/
cp -r $TMPDIR/dotfiles/.oh-my-zsh/custom/plugins/* ~/.oh-my-zsh/custom/plugins/
cp -r $TMPDIR/dotfiles/.dir_colors $TMPDIR/dotfiles/.gemrc $TMPDIR/dotfiles/.gitconfig $TMPDIR/dotfiles/.gitignore_global ~/
source ~/.zshrc
```

## [p10k](https://github.com/romkatv/powerlevel10k)

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Set `ZSH_THEME="powerlevel10k/powerlevel10k"` in `~/.zshrc`.

## [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

```
plugins=(zsh-autosuggestions)
```

## Homebrew – [brew.sh](http://brew.sh)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew doctor
brew install git git-lfs hub coreutils gpg mc imagemagick jq
```

## [RVM.io](https://rvm.io)

```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

# additional links

- [iTerm 2 Peppermint theme](https://github.com/dotzero/iTerm-2-Peppermint)
