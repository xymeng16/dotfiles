#!/usr/bin/env bash

if git submodule status | grep --quiet '^-'; then
  echo "Please initialize submodules first."
  exit 1
fi

SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname $SCRIPT)
FCITX5_DIR="$HOME/.local/share/fcitx5/"
CONFIG_DIR="$HOME/.config/"

CONFIGS_TO_BE_INSTALLED="fish gdb nvim tex wezterm starship"

# Install the necessary packages
# Distribution-specific commands should be provided
# TODO: Add more distribution-specific commands
# Arch Linux

ZH_CN_FONTS="adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts noto-fonts-cjk wqy-microhei wqy-microhei-lite wqy-bitmapfont wqy-zenhei ttf-arphic-ukai ttf-arphic-uming"
PKGS="fish tmux neovim tree-sitter tree-sitter-cli ripgrep fzf rust keychain fcitx5-im fcitx5-lua fcitx5-chinese-addons fcitx5-rime librime unzip"

sudo pacman -Syy
sudo pacman -S $ZH_CN_FONTS $PKGS

# TODO: Check if those environments exist
sudo tee -a /etc/environment >/dev/null <<'EOF'
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
SDL_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOF

mkdir -p "$FCITX5_DIR"
ln -s "$SCRIPT_DIR/rime" "$FCITX5_DIR"

for dir in $CONFIGS_TO_BE_INSTALLED; do
  if [ -d "$CONFIG_DIR/$dir" ]; then
    echo "$CONFIG_DIR/$dir exists"
  else
    ln -s "$SCRIPT_DIR/$dir" $CONFIG_DIR
    echo "$CONFIG_DIR/$dir copied"
  fi
done

# Install tmux related files
mkdir -p $CONFIG_DIR/tmux
ln -s "$SCRIPT_DIR/tmux/.tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
ln -s "$SCRIPT_DIR/tmux/.tmux.conf.local" "$CONFIG_DIR/tmux/tmux.conf.local"
