# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Color prompt
PS1="\[\033[1;32m\]\u@\h:\[\033[34m\]\w\[\033[00;1m\]\\$\[\033[00m\] "

# Force dark theme for GT3 apps
export GTK_THEME=Adwaita:dark

# Set up fzf key bindings and fuzzy completion
if [ -x "$(command -v fzf)" ]; then
    source /usr/share/fzf/shell/key-bindings.bash
	export FZF_DEFAULT_COMMAND="fd --hidden --type f --type d --type l"
	export FZF_CTRL_T_COMMAND="fd --hidden --type f --type d --type l"
	export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
fi

# Bat theme
export BAT_THEME="Visual Studio Dark+"

# Aliases
alias git-dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
