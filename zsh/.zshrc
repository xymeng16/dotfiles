# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Detect OS type
OS=$(uname)
case $OS in
    Linux)
        if [[ -e /home/xiangyi/Downloads/command-line-tools ]]; then
            export PATH="/home/xiangyi/Downloads/command-line-tools/bin:$PATH"
            export PATH="/home/xiangyi/Downloads/command-line-tools/sdk/HarmonyOS-NEXT-DB1/openharmony/toolchains:$PATH"
            export OHOS_NDK_HOME="/home/xiangyi/Downloads/command-line-tools/sdk/HarmonyOS-NEXT-DB1/openharmony"
        fi
        ;;
    Darwin)
        # Setup Homebrew
        if [[ -e /opt/homebrew/bin/brew ]]; then
            export PATH="/opt/homebrew/bin:$PATH"
        fi
        if [[ -e /opt/homebrew/bin/orb ]]; then
            export PATH="/Users/xiangyi/.orbstack/bin:$PATH"
        fi
        export OHOS_NDK_HOME="/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/"
        export PATH="/Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/toolchains:$PATH"
        export PATH="/Applications/DevEco-Studio.app/Contents/tools/ohpm/bin:$PATH"
        export PATH="/Users/xiangyi/.local/bin:$PATH"
        export PATH="/Users/xiangyi/go/bin:$PATH"
        export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
        ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NVM_LIST=$(nvm list 2>/dev/null)
#
# if [[ -n "$NVM_LIST" ]]; then
#     for line in ${(f)NVM_LIST}; do
#         if [[ $line =~ "->\s*v([0-9]+\.[0-9]+\.[0-9]+)" ]]; then
#             NVM_VERSION=$match[1]  
#             nvm use "v$NVM_VERSION" 
#             break
#         fi
#     done
# else
#     echo "node is not installed."
# fi
nvm use node

# Setup Miniconda if installed
if [[ -e ~/miniconda3 ]]; then
    export PATH="$HOME/miniconda3/condabin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"

export SHELL=$(which zsh)
eval "$(keychain --eval --quiet -Q id_rsa)"

# Define aliases
alias s="sudo"
alias se="sudo -E"
alias v="nvim"
alias ta="tmux a"
alias gs="git status"

# Define variables
export EDITOR=nvim
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache

# Conda initialize
if [[ -f ~/miniconda3/bin/conda ]]; then
    eval "$(~/miniconda3/bin/conda shell.zsh hook)"
else
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

if [[ -f ~/.cache/lm-studio/bin ]]; then
    export PATH="$PATH:/home/xiangyi/.cache/lm-studio/bin"
fi

export PATH="$HOME/.cargo/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/xiangyi/.cache/lm-studio/bin"

# Added by Windsurf
export PATH="$PATH:/Users/xiangyi/.codeium/windsurf/bin"

