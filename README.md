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

## Homebrew – [brew.sh](http://brew.sh)

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install git git-lfs hub coreutils gpg mc imagemagick unrar
```

## [RVM.io](https://rvm.io)

```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

# additional links

- [iTerm 2 Peppermint theme](https://github.com/dotzero/iTerm-2-Peppermint)
