# quick start

## this repo

```shell
xcode-select --install
git clone https://github.com/chipp/dotfiles ~/dotfiles
```

## Homebrew – [brew.sh](http://brew.sh)

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew install 1password-cli coreutils docker docker-buildx docker-completion docker-compose docker-credential-helper fish fsnotes git git-lfs gpg hub imagemagick jq midnight-commander mosh mosquitto node pinentry-mac podman podman-desktop provisionql python qemu xcinfo
```

## [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)

```shell
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
cp -r ~/dotfiles/.dir_colors ~/dotfiles/.gemrc ~/dotfiles/.gitconfig ~/dotfiles/.gitignore_global ~/
mkdir -p ~/.config
cp -r ~/dotfiles/omf ~/.config/
```

## ssh config

```shell
mkdir -m 700 -p ~/.ssh
cp ~/dotfiles/ssh_config ~/.ssh/config
```

## [RVM.io](https://rvm.io)

```shell
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash
```

## GPG

```shell
mkdir -m 700 -p ~/.gnupg

cp ~/dotfiles/.gnupg/gpg.conf ~/dotfiles/.gnupg/gpg-agent.conf ~/.gnupg
killall gpg-agent

gpg --import gpg.private.key
gpg --import-ownertrust ~/dotfiles/.gnupg/ownertrust-gpg.txt
```

## Xcode

```shell
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
mkdir -p ~/Library/Developer/Xcode/UserData/KeyBindings

cp ~/dotfiles/Library/Developer/Xcode/UserData/FontAndColorThemes/One\ Dark.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp ~/dotfiles/Library/Developer/Xcode/UserData/KeyBindings/My.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/

defaults write com.apple.dt.Xcode XCFontAndColorCurrentDarkTheme -string "One Dark.xccolortheme"
defaults write com.apple.dt.Xcode IDEKeyBindingCurrentPreferenceSet -string "My.idekeybindings"
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -int 1
```

## Sublime Text and Sublime Merge

```shell
mkdir -p ~/Library/Application\ Support/Sublime\ Text/Packages/User/
mkdir -p ~/Library/Application\ Support/Sublime\ Merge/Packages/User/

cp -r ~/dotfiles/Library/Application\ Support/Sublime\ Text/Packages/User/* ~/Library/Application\ Support/Sublime\ Text/Packages/User/
cp -r ~/dotfiles/Library/Application\ Support/Sublime\ Merge/Packages/User/* ~/Library/Application\ Support/Sublime\ Merge/Packages/User/
```

# additional links

- [iTerm 2 Peppermint theme](https://github.com/dotzero/iTerm-2-Peppermint)
