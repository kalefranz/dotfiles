# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Include machine specific options (i.e. one for work, one for home, one for VPS
# hosts, etc.)
#source ~/.zshrc.include

alias localip='ifconfig | grep -E -A3 "e(th|n)0" | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"'
alias externalip='echo $(curl -s --connect-timeout 3 http://ipecho.net/plain)'
alias ips='echo "local:" $(localip) " external:" $(echo $(curl -s --connect-timeout 2 http://ipecho.net/plain))'




insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

alias gs='git status'



# prepend PATH
export PATH=$HOME/anaconda/bin:$PATH

# postpend PATH
export PATH=$PATH:$JAVA_HOME/bin:$HOME/bin




#####
# TODO: everything below this line

#alias ls='pwd; ls --color'
#la
#ll

# http://stackoverflow.com/questions/171563/whats-in-your-zshrc

#{{{ Globals...

#alias -g G="| grep"
#alias -g L="| less"

#}}}

#{{{ Suffixes...

#if [[ -x `which abiword` ]]; then
#  alias -s doc=abiword
#fi
#if [[ -x `which ooimpress` ]]; then
#  alias -s ppt='ooimpress &> /dev/null '
#fi


# oh wow!  This is killer...  try it!
#bindkey -M vicmd "q" push-line


# ssh-add