# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias localip='/sbin/ifconfig | grep -E -A3 "e(th|n)0" | grep -Eo "inet (addr:)?([0-9]*\.){3}[0-9]*" | grep -Eo "([0-9]*\.){3}[0-9]*" | grep -v "127.0.0.1"'

function externalip () {
    TIMEOUT=${1:=3}  # default to 3 second timeout on http connection
	JSON=$(curl -s -m ${TIMEOUT} http://ipinfo.io/json)
	IP=$(echo $JSON | gawk 'match($0, /"ip":\s*"([0-9.]+)"/, ary) {print ary[1]}')
	ORG=$(echo $JSON | gawk 'match($0, /"org":\s*"([^"]+)"/, ary) {print ary[1]}')
	echo $IP $ORG
}

alias ips='echo "$(external-ip)"; echo "$(ifips)"'

alias gs='git status'
alias ga='git add'
alias gaa='cd "$(git rev-parse --show-toplevel)" && git add --all'
alias gcm='git commit --message'
alias gca='git commit --amend'
alias gcmm='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'
alias gus='git pull --rebase && git submodule update --init --recursive'

# Include machine specific options (i.e. one for work, one for home, one for VPS
# hosts, etc.)
if test -e $HOME/.zshrc.include; then
    source $HOME/.zshrc.include
fi



PERL_MB_OPT="--install_base \"/Users/kale/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/kale/perl5"; export PERL_MM_OPT;

export EDITOR=vim

alias ssha='ssh -i ~/.ssh/ansible-insecure ansible@\b'
