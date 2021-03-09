# quick start

## this repo

```shell
xcode-select --install
git clone https://github.com/chipp/dotfiles $HOME/dotfiles
```

## [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp $HOME/dotfiles/.zshrc ~/
cp -r $HOME/dotfiles/.oh-my-zsh/custom/plugins/* ~/.oh-my-zsh/custom/plugins/
cp -r $HOME/dotfiles/.dir_colors $HOME/dotfiles/.gemrc $HOME/dotfiles/.gitconfig $HOME/dotfiles/.gitignore_global ~/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp -r $HOME/dotfiles/.p10k.zsh ~/
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ~/.zshrc
```

## ssh config

```shell
mkdir -m 700 -p ~/.ssh
cp $HOME/dotfiles/ssh_config ~/.ssh/config
```

## Homebrew – [brew.sh](http://brew.sh)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew install git git-lfs hub coreutils gpg mc imagemagick jq rust-analyzer pinentry-mac
```

## [RVM.io](https://rvm.io)

```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
```

## GPG

```shell
mkdir -m 700 -p ~/.gnupg

cp .gnupg/gpg.conf .gnupg/gpg-agent.conf ~/.gnupg
killall gpg-agent

gpg --import gpg.private.key
gpg --import-ownertrust $HOME/dotfiles/.gnupg/ownertrust-gpg.txt
```

## Xcode

```shell
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
mkdir -p ~/Library/Developer/Xcode/UserData/KeyBindings

cp $HOME/dotfiles/Library/Developer/Xcode/UserData/FontAndColorThemes/One\ Dark.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp $HOME/dotfiles/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/

defaults write com.apple.dt.Xcode XCFontAndColorCurrentDarkTheme -string "One Dark.xccolortheme"
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -int 1
```

## Sublime Text and Sublime Merge

```shell
mkdir -p ~/Library/Application\ Support/Sublime\ Text/Packages/User/
mkdir -p ~/Library/Application\ Support/Sublime\ Merge/Packages/User/

cp -r $HOME/dotfiles/Library/Application\ Support/Sublime\ Text/Packages/User/* ~/Library/Application\ Support/Sublime\ Text/Packages/User/
cp -r $HOME/dotfiles/Library/Application\ Support/Sublime\ Merge/Packages/User/* ~/Library/Application\ Support/Sublime\ Merge/Packages/User/
```

# additional links

- [iTerm 2 Peppermint theme](https://github.com/dotzero/iTerm-2-Peppermint)
