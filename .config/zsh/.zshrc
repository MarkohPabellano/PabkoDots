#--Easy Stuff--#
export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='kitty'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
#source ~/.config/zsh/.zprofile # -- AutoInitiate -- #
source ~/.config/zsh/.zsh_aliases # -- Aliases -- #

#--History in cache directory--#
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history
setopt SHARE_HISTORY

#--PLUGINS--#
# link: https://github.com/zsh-users/zsh-syntax-highlighting.git
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
# link: https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh 
# https://github.com/zsh-users/zsh-history-substring-search.git
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh 

#source ~/.config/zsh/zsh-auto-notify/auto-notify.plugin.zsh
#source ~/.config/zsh/you-should-use/you-should-use.plugin.zsh

#--Completion--#
zstyle ':completion:*' menu select

#--Prompt--#
#source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
#eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/bubbles.omp.json)"
eval "$(starship init zsh)"



#--History Substring Search Options--#
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#--Shopt--#
#shopt -s autocd # change to named directory
#shopt -s cdspell # autocorrects cd misspellings
#shopt -s cmdhist # save multi-line commands in history as single line
#shopt -s dotglob
#shopt -s histappend # do not overwrite history
#shopt -s expand_aliases # expand aliases
#shopt -s checkwinsize # checks term size when bash regains control

#--ignore upper and lowercase when TAB completion--#
#bind "set completion-ignore-case on"

#--Archive Extraction--#
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#--navigation--#
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}


#--Bash Insulter--#
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
#[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(zellij setup --generate-auto-start zsh)"

