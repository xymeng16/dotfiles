#! /bin/bash

# install dependencies

# check if homebrew in installed
# if not, install it
if ! command -v brew &>/dev/null; then
	echo "Homebrew is not installed. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install dependencies
brew install fish neovim ripgrep fd jesseduffield/lazygit/lazygit koekeishiya/formulae/yabai
brew install --cask wezterm

# change default shell to fish
chsh -s $(which fish)

# install fisher
echo "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" | fish

# install fish plugins
echo "fisher install jorgebucaran/nvm.fish" | fish

# install node:latest
echo "nvm install latest" | fish

# create symlinks
ln -s $(pwd)/fish $HOME/.config/fish"
ln -s $(pwd)/nvim $HOME/.config/nvim"
ln -s $(pwd)/wezterm $HOME/.config/wezterm"
ln -s $(pwd)/yabai $HOME/.config/yabai"

echo "Installed successfully. You will need to reopen your terminal."
echo ""
