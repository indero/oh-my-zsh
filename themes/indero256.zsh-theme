#based on the yux256colors theme from luxflux
#using ubuntuish like colors
# define all the 256 colors

if [ "$TERM" != "linux" ]; then
  SPACER_COLOR=$FG[059]
  HOSTNAME_COLOR=$FG[214]
  PWD_COLOR=$FX[bold]$FG[220]
  SCREEN_SESSION_COLOR=$FG[034]
  if [ "$USER" = "root" ]; then
    USER_COLOR=$FG[196]
  else
    if [ `hostname` = $ZSH_THEME_SPECIAL_HOST ]; then
      USER_COLOR=$FX[bold]$FG[012]
      HOSTNAME_COLOR=$FG[012]
    else
      USER_COLOR=$FG[026]
    fi
  fi
  PR_RESET="%{$reset_color%}"
  if [[ $WINDOW == "" ]]; then
    PROMPT_SCREEN_SESSION=''
  else
    PROMPT_SCREEN_SESSION="%{$SPACER_COLOR%}(%{$SCREEN_SESSION_COLOR%}$WINDOW%{$SPACER_COLOR%})"
  fi
fi
my_rvm_prompt() {
  rvm_prompt_bin="$HOME/.rvm/bin/rvm-prompt"
  if [ -x ${rvm_prompt_bin} ]; then
    ruby_version=$(${rvm_prompt_bin} v)
    gemset=$(${rvm_prompt_bin} g)
    zsh_rvm_prompt="$FG[124]${ruby_version}%f$FG[154]${gemset}%{$reset_color%}"
  else
    zsh_rvm_prompt=""
  fi
  echo $zsh_rvm_prompt
}

PROMPT="%{$USER_COLOR%}%n$PROMPT_SCREEN_SESSION%{$USER_COLOR%}@%{$HOSTNAME_COLOR%}%m%{$PR_RESET%}:%{$PWD_COLOR%}%~%{$PR_RESET%} $ "
PS2="%{$USER_COLOR%}%#%{$SPACER_COLOR%}]>%{$PR_RESET%} "
RPROMPT='$(git_prompt_info)$(svn_prompt_info)$(my_rvm_prompt)'

# git color config
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}(git)-[%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✘%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

function svn_prompt_info {
    if [ $(in_svn) ]; then
        echo "$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_SVN_PROMPT_PREFIX\
$ZSH_THEME_REPO_NAME_COLOR$(svn_get_repo_name)$ZSH_PROMPT_BASE_COLOR$ZSH_THEME_SVN_PROMPT_REVISION$(svn_get_rev_nr)$ZSH_THEME_SVN_PROMPT_SUFFIX$ZSH_PROMPT_BASE_COLOR$(svn_dirty)$ZSH_PROMPT_BASE_COLOR"
    fi
}

# svn color config
ZSH_THEME_SVN_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}(svn)-[%{$reset_color%}"
ZSH_THEME_REPO_NAME_COLOR="$fg[124]"
ZSH_THEME_SVN_PROMPT_SUFFIX=""
ZSH_THEME_SVN_PROMPT_DIRTY=" %{$fg[red]%}✘%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" %{$fg[green]%}✔%{$fg[green]%}]%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_REVISION=":"
# rvm config

