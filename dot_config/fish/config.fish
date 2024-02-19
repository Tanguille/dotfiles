fastfetch

# Aliases
alias ls "/usr/bin/eza --icons --group-directories-first --color-scale -bghm"
alias update "sudo dnf upgrade --refresh -y && sudo dnf autoremove -y && flatpak update -y && brew upgrade && fisher update && omf update && rustup update && cargo install-update -a"
alias speedtest "python speedtest-cli"
#alias cat "bat"
alias grep "rg"
alias cc "cargo lcheck"
alias cb "cargo build && cargo clippy"
alias cf "cargo fmt"
alias dnf "dnf5"

# function cargo
    # if test "$argv[1]" = "install"
        # command cargo binstall $argv[2..-1]
    # else
        # command cargo $argv
    # end
# end
    
# Env's
## From /home/linuxbrew/.linuxbrew/bin/brew shellenv
set -gx HOMEBREW_PREFIX     "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_CELLAR     "/home/linuxbrew/.linuxbrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
set -g fish_user_paths "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $fish_user_paths
set -q MANPATH ; or set MANPATH  ''; set -gx MANPATH  "/home/linuxbrew/.linuxbrew/share/man"  $MANPATH
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH

# This is a hack to prevent this file from being sourced twice
if not status is-interactive
    exit
end

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

test -e ~/.profile && source ~/.profile

function postexec-source-profile --on-event fish_postexec
    set command_line (echo $argv | string collect | string trim)

    if string match -qr "^$EDITOR " "$command_line"
        set file (echo $command_line | coln 2 | string replace '~' $HOME)
        for config_file in ~/.profile ~/.config/fish/config.fish
            if test (realpath -- $file) = (realpath $config_file)
                echo -n "Sourcing "(echo $file | unexpand-home-tilde)"... "
                source $file
                echo done.
            end
        end
    end
end

# TODO rewrite this using event emitters
function save-error --on-event fish_postexec
    set exit_status $status
    set cancel_status 130

    if not contains $exit_status 0 $cancel_status && \
      not startswith retry "$argv" && \
      not startswith sudo-retry "$argv"
        set -g failed_command "$argv"
    end
end

function save-edited-file --on-event fish_postexec
    set command_line (echo $argv | string collect | string trim)
    if string match -qr "^($EDITOR|edit) " "$command_line"
        set -g editor_command $argv
    end
end

zoxide init fish | source
starship init fish | source
