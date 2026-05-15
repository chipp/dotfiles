# quick start

## this repo

```shell
sudo apt update
sudo apt install -y git
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
sudo apt install -y ca-certificates curl gpg jq lsb-release mc mosh vim
sudo mkdir -p --mode=0755 /usr/share/keyrings

if [ "$(lsb_release -si)" = "Debian" ]; then
    fish_debian_version="$(lsb_release -sr)"
    echo "deb [signed-by=/usr/share/keyrings/shells_fish_release_4.gpg] http://download.opensuse.org/repositories/shells:/fish:/release:/4/Debian_${fish_debian_version}/ /" | sudo tee /etc/apt/sources.list.d/shells:fish:release:4.list
    curl -fsSL "https://download.opensuse.org/repositories/shells:fish:release:4/Debian_${fish_debian_version}/Release.key" | sudo gpg --dearmor --yes -o /usr/share/keyrings/shells_fish_release_4.gpg
elif [ "$(lsb_release -si)" = "Ubuntu" ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/fish.gpg] https://ppa.launchpadcontent.net/fish-shell/release-4/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/fish-shell.list > /dev/null
    sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/fish.gpg --keyserver keyserver.ubuntu.com --recv-keys 88421E703EDC7AF54967DED473C9FCC9E2BB48DA
else
    exit 1
fi

curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" | sudo tee /etc/apt/sources.list.d/cloudflared.list

sudo apt update
sudo apt install -y fish cloudflared
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
