if status is-interactive
    # Commands to run in interactive sessions can go here 
    # detect OS type
    set OS (uname)
    switch $OS
        case Linux
            if test -e /home/xiangyi/Downloads/command-line-tools
                fish_add_path /home/xiangyi/Downloads/command-line-tools/bin
                fish_add_path /home/xiangyi/Downloads/command-line-tools/sdk/HarmonyOS-NEXT-DB1/openharmony/toolchains
            end
        case Darwin
            # setup homebrew
            # check if homebrew is installed
            if test -e /opt/homebrew/bin/brew
                fish_add_path /opt/homebrew/bin
            end
            if test -e /opt/homebrew/bin/orb
                set -gxa PATH /Users/xiangyi/.orbstack/bin
            end
            set -x OHOS_NDK_HOME /Applications/DevEco-Studio.app/Contents/sdk/HarmonyOS-NEXT-DB1/openharmony/
    end
    # setup miniconda if installed
    if test -e ~/miniconda3
        fish_add_path ~/miniconda3/bin
    end
    fish_add_path ~/.local/bin
    oh-my-posh init fish --config "~/.config/fish/omp/1_shell.omp.json" | source
    keychain --eval --quiet -Q id_rsa | source

    # define alias
    alias s="sudo"
    alias se="sudo -E"
    alias v="nvim"
    alias ta="tmux a"
    # define variables
    set -gx EDITOR nvim
    set -gx USE_CCACHE 1
    set -gx CCACHE_EXEC /usr/bin/ccache

    if test -f /home/xiangyi/miniconda3/bin/conda
        eval /home/xiangyi/miniconda3/bin/conda "shell.fish" hook $argv | source
    else
        if test -f "/home/xiangyi/miniconda3/etc/fish/conf.d/conda.fish"
            . "/home/xiangyi/miniconda3/etc/fish/conf.d/conda.fish"
        else
            set -x PATH /home/xiangyi/miniconda3/bin $PATH
        end
    end
end


