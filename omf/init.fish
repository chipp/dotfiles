alias ds="docker compose"

if test -e ~/.dir_colors
    eval (dircolors -c ~/.dir_colors)
else if test -e /etc/DIR_COLORS
    eval (dircolors -c /etc/DIR_COLORS)
end

fish_config theme choose my_default

set -xg COLORTERM truecolor
set -xg theme_color_scheme terminal
set -xg theme_nerd_fonts yes
set -xg theme_date_format "+%F %r"

set -xg GPG_TTY (tty)

set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
