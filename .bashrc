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

########################################
# Utils
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
PS1="\[\033[1;32m\]\u@\h:\[\033[34m\]\w\[\033[00;1m\]\\$\[\033[00m\] "

# Force dark theme for GT3 apps
export GTK_THEME=Adwaita:dark

# Bat theme
export BAT_THEME="Visual Studio Dark+"

########################################
# Aliases
########################################

alias vpn="nordvpn"
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
