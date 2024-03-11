#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::aliases'

###############################################################################################
####################################### PUBLIC ALIASES ########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- NAVIGATION --------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Print Working Dir to Clipboard
command -v pbcopy > /dev/null 2>&1 && alias cpwd='pwd|tr -d "\n"|pbcopy'

# Echo PATH
alias path='echo -e ${PATH//:/\\n}'

# Up one level
alias ..='cd ..'
# Up two levels
alias ...='cd ../../'

alias ls='ls -Fh'
alias la='ls -FAh'
alias ll='ls -Flh'
alias lss='du -sh * | sort -h'


###-----------------------------------------------------------------------------------------###
###--- RANDOM ------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Sudo Commands
command -v nmap > /dev/null 2>&1 && alias snmap='sudo nmap'
command -v nano > /dev/null 2>&1 && alias snano='sudo nano '
command -v vim > /dev/null 2>&1 && alias svim='sudo vim '
command -v htop > /dev/null 2>&1 && alias shtop='sudo htop'

# Get Public IP
alias publicIP="printf '%s\n' \$(curl --silent http://ifconfig.me)"

# Knock-off tree command if the tree utility isnt installed
! command -v tree > /dev/null 2>&1 && alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"


###-----------------------------------------------------------------------------------------###
###--- GITHUB ------------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v git >/dev/null 2>&1; then
	# Add all and commit
	alias gac='git add . && git commit -m '
	# Add all, Commit, Push to master
	gitQuickMasterPush() {
		git add .
		git commit -m "Quick update"
		git push origin master
	}
	alias gq='gitQuickMasterPush'
fi


###-----------------------------------------------------------------------------------------###
###--- YOUTUBE -----------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v yt-dlp >/dev/null 2>&1; then
	alias songGetter='yt-dlp -x --audio-format mp3'
	alias videoGetter='yt-dlp -S "ext" -f bestvideo+bestaudio'
	[ -s "${HOME}/.scripts-supplemental/youtube-dl-cookie.txt" ] && alias videoGetterRestricted='yt-dlp --cookie ${HOME}/.scripts-supplemental/youtube-dl-cookie.txt -S "ext" -f bestvideo+bestaudio'
fi


###-----------------------------------------------------------------------------------------###
###--- CLAM AV -----------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

command -v freshclam >/dev/null 2>&1 && alias virusUpdate="freshclam -v"
command -v clamscan >/dev/null 2>&1 && alias virusScan="clamscan --recursive=yes --bell -i "


###-----------------------------------------------------------------------------------------###
###--- MAC OS ONLY -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Restart Audio Service on Macbook
# shellcheck disable=SC2142
is_mac && alias restartSound='sudo kill -9 $(pgrep -f "coreaudio[a-z]" | awk "{print $1}")'
# Lock Computer on Macbook
command -v osascript >/dev/null 2>&1 && alias afk='osascript -e "tell application "System Events" to start current screen saver"'
# Java home executable
command -v /usr/libexec/java_home >/dev/null 2>&1 && alias java_home="/usr/libexec/java_home"


###-----------------------------------------------------------------------------------------###
###--- SHELL CUSTOMIZATION -----------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if is_bash;then
	alias src='source ${HOME}/.bashrc'
	command -v vim >/dev/null 2>&1 && alias eProfile='vim ${HOME}/.bashrc'
	command -v code >/dev/null 2>&1 && alias eProfileVs='code ${HOME}/.bashrc'
elif is_zsh;then
	alias src='source ${HOME}/.zshrc'
	command -v vim >/dev/null 2>&1 && alias eProfile='vim ${HOME}/.zshrc'
	command -v code >/dev/null 2>&1 && alias eProfileVs='code ${HOME}/.zshrc'
elif is_sh;then
	alias src='source ${HOME}/.profile'
	command -v vim >/dev/null 2>&1 && alias eProfile='vim ${HOME}/.profile'
	command -v code >/dev/null 2>&1 && alias eProfileVs='code ${HOME}/.profile'
else
	printf '[ERROR] Unknown shell type!\n'
	exit 1
fi

###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###










#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################