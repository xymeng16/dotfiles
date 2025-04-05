#!/usr/bin/env zsh

# assuming that zsh is installed
if git submodule status --quiet '^-'; then
  echo "Please initialize submodules first."
  exit 1
fi

# install oh-my-zsh related files
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
nvm install node

SCRIPT=$(readline -f "$0")
SCRIPT_DIR=$(dirname $SCRIPT)
CONFIG_DIR="$HOME/.config/"

CONFIGS_TO_BE_INSTALLED="zsh nvim gdb" # headless server

# TODO: Install the necessary packages
# check the distribution first
PKGS="tmux neovim tree-sitter tree-sitter-cli ripgrep fzf rust keychain unzip"

sudo pacman -Syy
sudo pacman -S $PKGS

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
