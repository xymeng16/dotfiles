function remove_path
    if set -l index (contains -i "$argv" $fish_user_paths)
        set -e fish_user_paths[$index]
        echo "Removed $argv from the fish_user_path"
    end

    if set -l index (contains -i "$argv" $PATH)
        set -e PATH[$index]
        echo "Removed $argv from the PATH"
    end
end
