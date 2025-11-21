# .bashrc

########################################
# Source other files
########################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

########################################
# Paths
########################################

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export TERMINAL="/usr/bin/kitty"
export EDITOR="/usr/bin/nvim"

########################################
# Tools
########################################


# Initialize zoxide (cd with history)
eval "$(zoxide init bash)"

# Set up fzf key bindings and fuzzy completion
if [ -x "$(command -v fzf)" ]; then
    source /usr/share/fzf/shell/key-bindings.bash
	export FZF_DEFAULT_COMMAND="fd --hidden --type f --type d --type l"
	export FZF_CTRL_T_COMMAND="fd --hidden --type f --type d --type l"
	export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
fi

########################################
# Cosmetic
########################################

# Custom prompt with color
function fancy_prompt {
    local RESET='\[\033[0;00m\]'
    case $TERM in
        alacritty|xterm-kitty)
            local TRIANGLE=$'\uE0B0'
            local USER="\[\033[43;1;30m\] \u \[\033[42;1;33m\]$TRIANGLE"
            local HOST="\[\033[42;1;30m\] \h \[\033[44;1;32m\]$TRIANGLE"
            local PWD="\[\033[44;1;30m\] \w \[\033[0;34m\]$TRIANGLE"
            local END="$RESET "
	    ;;
        *)
            local USER="\[\033[1;33m\]\u"
            local HOST="\[\033[1;32m\]@\h"
            local PWD="\[\033[1;34m\]:\w"
            local END="$RESET \$ "
	    ;;
        esac
    echo "$USER$HOST$PWD$END"
}
PS1="$(fancy_prompt)"
unset fancy_prompt

# Force dark theme for GT3 apps
# export GTK_THEME=Adwaita:dark
export GTK_THEME=Flat-Remix-GTK-Blue-Dark

# Force dark theme for QT5 apps
export QT_QPA_PLATFORMTHEME=qt5ct

# Newt (whiptail) color scheme
export NEWT_COLORS_FILE=$HOME/.config/newt/colors

########################################
# Aliases
########################################

alias vim="nvim"
alias gl="git log --oneline"

# cd -> z
which z > /dev/null && alias cd="z"

# ls -> eza
if [ -x "$(command -v eza)" ]; then
	alias ls="eza --color=always --icons=always"
	alias lls="eza --color=always --icons=always --long"
fi

# git dotfiles
function git_dotfiles {
  if [ "$PWD" == "$HOME" ] || [ "$PWD" == "$HOME/.dotfiles" ]; then
	git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
  else
    git "$@"
  fi
}
alias git="git_dotfiles"

# lazygit
function lazygit_dotfiles {
  if [ "$PWD" == "$HOME" ] || [ "$PWD" == "$HOME/.dotfiles" ]; then
    lazygit --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
  else
    lazygit "$@"
  fi
}
alias lg="lazygit_dotfiles"
