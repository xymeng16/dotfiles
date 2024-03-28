if status is-interactive
    # Commands to run in interactive sessions can go here 
    oh-my-posh init fish --config "~/.config/fish/omp/1_shell.omp.json" | source
    eval "$(/home/xiangyi/miniconda3/bin/conda shell.fish hook)"
end
