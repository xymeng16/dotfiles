#! /bin/bash

if ! command -v rustup &>/dev/null; then
	echo "Rust is not installed. Installing Rust..."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	source $HOME/.cargo/env
fi

if ! command -v brew &>/dev/null; then
	echo "Homebrew is not installed. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install dependencies
brew install font-blex-mono-nerd-font fish neovim fzf ripgrep fd jesseduffield/lazygit/lazygit keychain starship stats tmux
brew install --cask wezterm

# change default shell to fish
if ! grep -q "$(which fish)" /etc/shells; then
	echo "$(which fish)" | sudo tee -a /etc/shells
fi
chsh -s $(which fish)

# create symlinks
dirs=(btop fish gdb nvim wezterm starship tex)
if [ ! -d ~/.config ]; then
    mkdir -p ~/.config
fi
# remove possibly existing fish config dir
rm -rf ~/.config/fish
for dir in ${dirs[@]}; do
	ln -s $(pwd)/$dir ~/.config/
done

# # install fisher
# echo "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" | fish

# # install fish plugins
# echo "fisher install jorgebucaran/nvm.fish" | fish

# install node:latest
echo "nvm install latest" | fish

mkdir -p ~/.config/tmux
ln -s $(pwd)/tmux/.tmux.conf ~/.config/tmux/tmux.conf
ln -s $(pwd)/tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local

echo "Installed successfully. You will need to reopen your terminal."
echo ""
