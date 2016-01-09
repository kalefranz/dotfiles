# http://misc.flogisoft.com/bash/tip_colors_and_formatting

[[ -n "$HUDSON_URL" ]] && export TERM=xterm


prompt_bold=$(tput bold)
prompt_reset=$(tput sgr0)

prompt_black=$(tput setaf 0)
prompt_red=$(tput setaf 1)
prompt_green=$(tput setaf 2)
prompt_yellow=$(tput setaf 3)
prompt_blue=$(tput setaf 4)
prompt_purple=$(tput setaf 5)
prompt_cyan=$(tput setaf 6)
prompt_white=$(tput setaf 7)


git_dir=""

get_git_branch() {
  # On branches, this will return the branch name
  # On non-branches, (no branch)
  ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
  if [[ "$ref" != "" ]]; then
    if [[ ${#ref} -gt 16 ]]; then
      echo "$ref" | cut -c 1-13  # add ellipsis ... here
    else
      echo "$ref"
    fi
  else
    echo "(no branch)"
  fi
}

get_git_progress() {
  # Detect in-progress actions (e.g. merge, rebase)
  # https://github.com/git/git/blob/v1.9-rc2/wt-status.c#L1199-L1241
  #git_dir="$(git rev-parse --git-dir)"

  # git merge
  if [[ -f "$git_dir/MERGE_HEAD" ]]; then
    echo " [merge]"
  elif [[ -d "$git_dir/rebase-apply" ]]; then
    # git am
    if [[ -f "$git_dir/rebase-apply/applying" ]]; then
      echo " [am]"
    # git rebase
    else
      echo " [rebase]"
    fi
  elif [[ -d "$git_dir/rebase-merge" ]]; then
    # git rebase --interactive/--merge
    echo " [rebase]"
  elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
    # git cherry-pick
    echo " [cherry-pick]"
  fi
  if [[ -f "$git_dir/BISECT_LOG" ]]; then
    # git bisect
    echo " [bisect]"
  fi
  if [[ -f "$git_dir/REVERT_HEAD" ]]; then
    # git revert --no-commit
    echo " [revert]"
  fi
}

is_branch1_behind_branch2() {
  # Find the first log (if any) that is in branch1 but not branch2
  first_log="$(git log $1..$2 -1 2> /dev/null)"

  # Exit with 0 if there is a first log, 1 if there is not
  [[ -n "$first_log" ]]
}

branch_exists() {
  # List remote branches           | # Find our branch and exit with 0 or 1 if found/not found
  git branch --remote 2> /dev/null | grep --quiet "$1"
}

parse_git_ahead() {
  # Grab the local and remote branch
  branch="$(get_git_branch)"
  remote_branch="origin/$branch"

  # If the remote branch is behind the local branch
  # or it has not been merged into origin (remote branch doesn't exist)
  if (is_branch1_behind_branch2 "$remote_branch" "$branch" ||
      ! branch_exists "$remote_branch"); then
    # echo our character
    echo 1
  fi
}

parse_git_behind() {
  # Grab the branch
  branch="$(get_git_branch)"
  remote_branch="origin/$branch"

  # If the local branch is behind the remote branch
  if is_branch1_behind_branch2 "$branch" "$remote_branch"; then
    # echo our character
    echo 1
  fi
}

parse_git_dirty() {
  # If the git status has *any* changes (e.g. dirty), echo our character
  if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then
    echo 1
  fi
}

is_on_git() {
  git_dir=$(git rev-parse --git-dir 2> /dev/null)
}

get_git_status() {
  # Grab the git dirty and git behind
  dirty_branch="$(parse_git_dirty)"
  branch_ahead="$(parse_git_ahead)"
  branch_behind="$(parse_git_behind)"

  # Iterate through all the cases and if it matches, then echo
  if [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "⬢"
  elif [[ "$dirty_branch" == 1 && "$branch_ahead" == 1 ]]; then
    echo "▲"
  elif [[ "$dirty_branch" == 1 && "$branch_behind" == 1 ]]; then
    echo "▼"
  elif [[ "$branch_ahead" == 1 && "$branch_behind" == 1 ]]; then
    echo "⬡"
  elif [[ "$branch_ahead" == 1 ]]; then
    echo "△"
  elif [[ "$branch_behind" == 1 ]]; then
    echo "▽"
  elif [[ "$dirty_branch" == 1 ]]; then
    echo "*"
  fi
}

# Symbol displayed at the line of every prompt
get_prompt_symbol() {
  # If we are root, display `#`. Otherwise, `$`
  if [[ "$UID" == 0 ]]; then
    echo "#"
  else
    echo "❯"
  fi
}


if [[ $- == *i* ]]; then
  PS1='$(_exit=$?; [[ $_exit = 0 ]] || echo "\[${prompt_reset}\]\[${prompt_red}\]($_exit)")'
  PS1+="\[${prompt_reset}\]\[${prompt_bold}\]\[${prompt_green}\]\u"
  PS1+="\[${prompt_reset}\]\[${prompt_cyan}\]@\[${prompt_bold}\]\[${prompt_green}\]\h"
  PS1+="\[${prompt_reset}\]\[${prompt_cyan}\]:"
  PS1+="\[${prompt_bold}\]\[${prompt_blue}\]\w"
  PS1+='$(is_on_git && echo "\[${prompt_reset}\]\[${prompt_purple}\] *$(get_git_branch)")'
  PS1+="\[${prompt_reset}\]\[${prompt_bold}\]\[${prompt_white}\] $(get_prompt_symbol)\[${prompt_reset}\] "
fi



