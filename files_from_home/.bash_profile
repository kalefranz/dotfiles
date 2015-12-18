# ##############################
# /etc/profile.d/
# ##############################
_source_etc_profiled() {
    if [[ -d /etc/profile.d/ ]]; then
        # from CentOS 5 /etc/profile
        for i in /etc/profile.d/*.sh ; do
            if [ -r "$i" ]; then
                if [ "${-#*i}" != "$-" ]; then
                    . $i
                else
                    . $i >/dev/null 2>&1
                fi
            fi
        done
    fi
}
_source_etc_profiled

# ##############################
# environment
# ##############################
export EDITOR='vim'


# ##############################
# ip addresses
# ##############################
alias ips='echo $(ifips)'


# ##############################
# key bindings
# ##############################
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'


# ##############################
# git aliases
# ##############################
alias gs='git status'
alias ga='git add'
alias gaa='cd "$(git rev-parse --show-toplevel)" && git add --all'
alias gcm='git commit --message'
alias gca='git commit --amend'
alias gg='git grep --color --show-function -n -C 2'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'


# ##############################
# system aliases
# ##############################
alias ls='ls -hFG'
alias la='ls -alhFG'
alias ll='ls -alhFG'
alias ..='cd ..'

# an "alert" alias for long running commands.  Use like so:
#   $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# ##############################
# bash history
# ##############################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

HISTIGNORE='ls:ll:la:bg:fg:history'
HISTTIMEFORMAT='%F %T '
shopt -s cmdhist

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=10000
HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# ##############################
# from ubuntu default .bashrc
# ##############################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# ##############################
# ruby
# ##############################
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# ##############################
# python
# ##############################
export PATH=$PATH:/conda/bin
export PATH=$PATH:/usr/local/share/pypy


# ##############################
# local
# ##############################
if [[ -f "$HOME/.bashrc.local" ]]; then
    . "$HOME/.bashrc.local"
fi

if [[ -f "$HOME/.bash_profile.local" ]]; then
    . "$HOME/.bash_profile.local"
fi
