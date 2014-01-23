# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias localip='/sbin/ifconfig | grep -E -A3 "e(th|n)0" | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"'
alias externalip='echo $(curl -s --connect-timeout 3 http://ipecho.net/plain)'
alias ips='echo "local:" $(localip) " external:" $(echo $(curl -s --connect-timeout 2 http://ipecho.net/plain))'

alias gs='git status'

# Include machine specific options (i.e. one for work, one for home, one for VPS
# hosts, etc.)
#source ~/.zshrc.include

