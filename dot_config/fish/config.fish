if status is-interactive
    fastfetch
end

# Ensure SSH_AUTH_SOCK points to the systemd-managed agent
set -x SSH_AUTH_SOCK /run/user/$UID/ssh-agent.socket

# Aliases
alias ls "/usr/bin/eza --icons --group-directories-first --color-scale -bghm"
alias update "sudo dnf upgrade --refresh -y && sudo dnf autoremove -y && flatpak update -y && rustup update && cargo install-update -a && mise self-update -y && mise upgrade && fisher update"
alias grep "rg"
alias cc "cargo lcheck"
alias cb "cargo clippy"
alias cf "cargo fmt"

for f in ~/.config/fish/functions/private/*
    source $f
end

# Functions
function last_history_item; echo $history[1]; end
abbr -a !! --position anywhere --function last_history_item

# Binds option-up
bind \e\[1\;5A history-token-search-backward
# Binds super-up (for emacs vterm integration, where there is no "option"
bind \e\[1\;2A history-token-search-backward

# option-down
bind \e\[1\;5B history-token-search-forward
# super-down
bind \e\[1\;2B history-token-search-forward

# Make C-t transpose characters :)
bind \ct transpose-chars

# Make C-s accept autocompletion and submit :))
bind \cs accept-autosuggestion execute

if test -e ~/.cargo/env.fish; source ~/.cargo/env.fish; end

# Auto-source config files after editing them
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

if status is-interactive
    zoxide init fish | source
    starship init fish | source
end

