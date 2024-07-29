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
sudo apt install -y gpg jq mc mosh vim curl

if [ $(lsb_release -si) == "Debian" ]; then
    echo "deb https://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_$(lsb_release -sr)/ /" | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list;
    curl -fsSL "https://download.opensuse.org/repositories/shells:fish:release:3/Debian_$(lsb_release -sr)/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null;
elif [ $(lsb_release -si) == "Ubuntu" ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/fish.gpg] https://ppa.launchpadcontent.net/fish-shell/release-3/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/fish-shell.list > /dev/null;
    sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/fish.gpg   --keyserver keyserver.ubuntu.com --recv-keys 59FDA1CE1B84B3FAD89366C027557F056DC33CA5;
else
    exit -1
fi

sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list

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
