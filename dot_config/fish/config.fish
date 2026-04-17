# Ensure SSH_AUTH_SOCK points to the systemd-managed agent
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

# Default editor (matches gitconfig)
set -gx EDITOR micro

# PATH additions (fish_add_path is idempotent — safe to re-run)
fish_add_path $HOME/.local/bin $HOME/.opencode/bin

if status is-interactive
    fastfetch

    # Aliases (absolute /usr/bin/eza avoids recursion with the `ls` alias)
    alias ls "/usr/bin/eza --icons --group-directories-first --color-scale -bghm"
    alias update "sudo dnf upgrade --refresh -y && sudo dnf autoremove -y && flatpak update -y && rustup update && cargo install-update -a && mise upgrade --bump && fisher update && fwupdmgr refresh --force && fwupdmgr update && claude upgrade"
    alias grep "rg"
    alias cc "cargo lcheck"
    alias cb "cargo clippy"
    alias cf "cargo fmt"

    function last_history_item; echo $history[1]; end
    abbr -a !! --position anywhere --function last_history_item

    # option-up / super-up (super covers emacs vterm where there's no option key)
    bind \e\[1\;5A history-token-search-backward
    bind \e\[1\;2A history-token-search-backward

    # option-down / super-down
    bind \e\[1\;5B history-token-search-forward
    bind \e\[1\;2B history-token-search-forward

    bind \ct transpose-chars
    bind \cs accept-autosuggestion execute

    # Auto-source config files after editing them in $EDITOR
    function postexec-source-profile --on-event fish_postexec
        set command_line (string trim -- "$argv")

        if string match -qr "^$EDITOR " "$command_line"
            set file (string split ' ' $command_line)[2]
            set file (string replace '~' $HOME $file)
            for config_file in ~/.profile ~/.config/fish/config.fish
                if test (realpath -- $file 2>/dev/null) = (realpath $config_file 2>/dev/null)
                    echo -n "Sourcing "(string replace $HOME '~' $file)"... "
                    source $file
                    echo done.
                end
            end
        end
    end

    zoxide init fish | source
    starship init fish | source
    mise activate fish | source
end
