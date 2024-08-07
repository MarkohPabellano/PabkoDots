#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#--EXPORTS--#
export BROWSER='brave-browser'
export LESSHISTFILE=-
export HISTFILE="$HOME/.config/bash/.bash_history"
export EDITOR='nvim'
export VISUAL='nvim'
export TERMINAL='kitty'
export PATH="$PATH:$HOME/.local/bin:$HOME/.config/emacs/bin"

#--PROMPT--#
#PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

#--Progams--#
#eval "$(zellij setup --generate-auto-start zsh)"
#neofetch
fastfetch

#--HISTFILE--
HISTSIZE=10000
#SAVEHIST=10000

###---------- ARCHIVE EXTRACT ----------###

ex() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7za e x $1 ;;
		*.deb) ar x $1 ;;
		*.tar.xz) tar xf $1 ;;
		*.tar.zst) unzstd $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

#--ALIASES--#

#alias sudo='doas'
alias sudo='sudo '
#--vim and emacs--#
alias code="/usr/share/code/bin/code"
alias vim="nvim"
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"
#alias doomsync="~/.config/emacs/bin/doom sync"
#alias doomdoctor="~/.config/emacs/bin/doom doctor"
#alias doomupgrade="~/.config/emacs/bin/doom upgrade"
#alias doompurge="~/.config/emacs/bin/doom purge"

#--hibernate, logout, and shutdown--#
#alias hi='systemctl suspend-then-hibernate'
#alias lo='killall xinit'
#alias ro='sudo shutdown -r now'
#alias ro='reboot'
#alias po='sudo poweroff -f'

#--root privileges--#
alias doas="doas --"

#--alias file management--#

#alias ls='lsd --color=auto'
#alias l='ls -l'
#alias la='ls -a'
#alias lla='ls -la'
alias l='lsd -a'
alias ll='lsd -l -a'

#--Software Maanagement Maintainance--#
alias update='paru -Syu --noconfirm && flatpak update' # update standard pkgs and AUR pkgs (paru)
alias unlock='sudo rm /var/lib/pacman/db.lck'          # remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'       # remove orphaned packages
alias refresh='sudo pacman -Syy'                       # refresh all of the pacman databases

#--get fastest mirrors--#
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

#--Colorize grep output (good for log files)--#
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#--confirm before overwriting something--#
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#--adding flags--#
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'
alias night='redshift -O 2700'

#--ps--#
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

#--Merge Xresources--#
alias merge='xrdb -merge ~/.Xresources'

#--git--#
alias gitmail='git config --global user.email "markohblpabellano@gmail.com"'
alias gitname='git config --global user.name "Markoh Pabellano"'
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status' # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'

#--Bare Git Repository Aliases--#
alias dots="/usr/bin/git --git-dir=$HOME/PabkoDots/ --work-tree=$HOME"
alias conmarkwall="/usr/bin/git --git-dir=$HOME/markwalls/ --work-tree=$HOME"
alias nountracked="config --local status.showUntrackedFiles no"

#--get error messages from journalctl--#
alias jctl="journalctl -p 3 -xb"

#--gpg encryption--#
#--verify signature for isos--#
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#--receive the key of a developer--#
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

#--youtube-dl--#
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

#--switch between shells--#
#--I do not recommend switching default SHELL from bash.--#
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#--termbin--#
#alias tb="nc termbin.com 9999"

#--the terminal rickroll--#
#alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

#--Text Editor Aliases--#
#alias code="/usr/share/codium/bin/codium"
#alias code='vscodium'
#alias codium="/usr/share/codium/bin/codium"

#--Unlock LBRY tips--#
#alias tips='lbrynet txo spend --type=support --is_not_my_input --blocking'

#--Script aliases--#
alias rice!="/home/marks/.config/scripts/setbg"
alias convertmov="/home/marks/.config/scripts/convertmov.sh"
alias wallpaper-wrap="/home/marks/.config/scripts/wallpaper-wrap"
