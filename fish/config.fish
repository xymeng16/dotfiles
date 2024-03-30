if status is-interactive
    # Commands to run in interactive sessions can go here 
    # detect OS type
    set OS (uname)
    switch $OS
        case Linux
        case Darwin
            # setup homebrew
            # check if homebrew is installed
            if test -e /opt/homebrew/bin/brew
                fish_add_path /opt/homebrew/bin
            end
    end
    # setup miniconda if installed
    if test -e ~/miniconda3
        fish_add_path ~/miniconda3/bin
    end
    oh-my-posh init fish --config "~/.config/fish/omp/1_shell.omp.json" | source
end
