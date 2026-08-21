if status is-interactive
    # Commands to run in interactive sessions can go here 
    # fish_config theme choose tokyonight_day
    fish_config theme choose tokyonight
    # detect OS type
    set OS (uname)
    switch $OS
        case Linux
            if test -e ~/Downloads/command-line-tools
                fish_add_path ~/Downloads/command-line-tools/bin
                fish_add_path ~/Downloads/command-line-tools/sdk/HarmonyOS-NEXT-DB1/openharmony/toolchains
                set -gx OHOS_NDK_HOME ~/Downloads/command-line-tools/sdk/HarmonyOS-NEXT-DB1/openharmony
            end
        case Darwin
            # setup homebrew
            # check if homebrew is installed
            if test -e /opt/homebrew/bin/brew
                fish_add_path /opt/homebrew/bin
            end
            if test -e /opt/homebrew/bin/orb
                fish_add_path ~/.orbstack/bin
            end
            set -x OHOS_NDK_HOME /Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/
            fish_add_path /Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/toolchains/
            fish_add_path /Applications/DevEco-Studio.app/Contents/tools/ohpm/bin/
            fish_add_path ~/.local/bin/
            fish_add_path ~/go/bin/
            fish_add_path /opt/homebrew/opt/llvm/bin/
            fish_add_path /opt/homebrew/opt/openjdk@11/bin
            fish_add_path ~/Library/Android/sdk/platform-tools
            set -x ANDROID_SDK_ROOT ~/Library/Android/sdk/
            set -x ANDROID_NDK_ROOT ~/Library/Android/sdk/ndk/r29/
    end

    # config node
    set NVM_LIST (nvm list)
    if set -q NVM_LIST
        for line in $NVM_LIST
            if string match -r 'v[0-9]+\.[0-9]+\.[0-9]+' $line
                set NVM_VERSION (string match -r 'v[0-9]+\.[0-9]+\.[0-9]+' $line)
                nvm use $NVM_VERSION
                break
            end
        end
    else
        echo "node is not installed."
    end

    # setup miniconda if installed
    if test -e ~/miniconda3
        #fish_add_path ~/miniconda3/bin
        #eval ~/miniconda3/bin/conda "shell.fish" hook $argv | source
        fish_add_path ~/miniconda3/condabin
    end

    fish_add_path ~/.local/bin

    #oh-my-posh init fish --config "~/.config/fish/omp/1_shell.omp.json" | source
    set -gx STARSHIP_CONFIG "~/.config/starship/starship.toml"
    starship init fish | source

    set -x SHELL (which fish)
    keychain --eval --quiet -Q id_rsa | source

    # define alias
    alias s="sudo"
    alias se="sudo -E"
    alias v="nvim"
    alias ta="tmux a"
    alias lc="leetcode"
    alias lcp="leetcode pick"
    alias lce="leetcode edit"
    alias lct="leetcode test"
    alias lcex="leetcode exec"

    # define variables
    set -gx EDITOR nvim
    set -gx USE_CCACHE 1
    set -gx CCACHE_EXEC /usr/bin/ccache

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if test -f ~/miniconda3/bin/conda
        eval ~/miniconda3/bin/conda "shell.fish" hook $argv | source
    else
        if test -f "~/miniconda3/etc/fish/conf.d/conda.fish"
            source "~/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH "~/miniconda3/bin" $PATH
        end
    end
    # <<< conda initialize <<<

    if test -f ~/.cache/lm-studio/bin
        set -gx PATH $PATH ~/.cache/lm-studio/bin
    end

    fish_add_path ~/.cargo/bin/
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH ~/.cache/lm-studio/bin

# Added by Windsurf
fish_add_path ~/.codeium/windsurf/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/xiangyi.meng/.lmstudio/bin
# End of LM Studio CLI section

fish_add_path $HOME/.local/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/xiangyi/.lmstudio/bin
# End of LM Studio CLI section


# opencode
fish_add_path /Users/xiangyi/.opencode/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :


set -gx MUSEAI_API_KEY 373486ef-5f01-438f-acaa-4b51a0e2ca95
