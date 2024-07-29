# quick start

## this repo

```shell
sudo apt update
sudo apt install git
git clone https://github.com/chipp/dotfiles -b linux ~/dotfiles
```

## Locale
```shell
echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
sudo locale-gen
echo 'LANG="en_US.UTF-8"' | sudo tee /etc/default/locale
```

## Packages

```shell
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
sudo apt update
sudo apt install -y fish gpg jq mc mosh vim
chsh -s /usr/bin/fish
```

## [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)

```shell
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

```shell
fish_config theme save "fish default"
cp -r ~/dotfiles/.dir_colors ~/dotfiles/.gemrc ~/dotfiles/.gitconfig ~/dotfiles/.gitignore_global ~/
mkdir -p ~/.config
cp -r ~/dotfiles/omf ~/.config/
omf install
omf reload
```

## GPG

```shell
gpg --import gpg.private.key
gpg --import-ownertrust ~/dotfiles/.gnupg/ownertrust-gpg.txt
```
