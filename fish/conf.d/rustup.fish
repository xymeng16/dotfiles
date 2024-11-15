if test -e "$HOME/.cargo"
    if not contains "$HOME/.cargo/bin" $PATH
        # Prepending path in case a system-installed rustc needs to be overridden
        set -x PATH "$HOME/.cargo/bin" $PATH
    end
    source "$HOME/.cargo/env.fish"
end
