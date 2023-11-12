#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::aliases'

###############################################################################################
####################################### PUBLIC ALIASES ########################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- NAVIGATION --------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Print Working Dir to Clipboard
[ -x "$(command -v pbcopy)" ] && alias cpwd='pwd|tr -d "\n"|pbcopy'

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
[ -x "$(command -v nmap)" ] && alias snmap='sudo nmap'
[ -x "$(command -v nano)" ] && alias snano='sudo nano '
[ -x "$(command -v vime)" ] && alias svim='sudo vim '
[ -x "$(command -v htop)" ] && alias htop='sudo htop'

# Get Public IP
alias publicIP='curl http://ifconfig.me; echo'

# Knock-off tree command if the tree utility isnt installed
[ ! -x "$(command -v tree)" ] && alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

# Man Summaries
[ -x "$(command -v tldr)" ] && alias sman="tldr"


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

[ -x "$(command -v freshclam)" ] && alias virusUpdate="freshclam -v"
[ -x "$(command -v clamscan)" ] && alias virusScan="clamscan --recursive=yes --bell -i "


###-----------------------------------------------------------------------------------------###
###--- MAC OS ONLY -------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

# Restart Audio Service on Macbook
[ "$(uname)" = "Darwin" ] && alias restartSound='sudo kill -9 $(pgrep -f "coreaudio[a-z]" | awk "{print $1}")'
# Lock Computer on Macbook
[ -x "$(command -v osascript)" ] && alias afk='osascript -e "tell application "System Events" to start current screen saver"'
# Java home executable
[ -x "$(command -v /usr/libexec/java_home)" ] && alias java_home="/usr/libexec/java_home"


###-----------------------------------------------------------------------------------------###
###--- ZSH CUSTOMIZATION -------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

alias src='source ${HOME}/.zshrc'
[ -x "$(command -v vim)" ] && alias eProfile='vim ${HOME}/.zshrc'
[ -x "$(command -v code)" ] && alias eProfileVs='code ${HOME}/.zshrc'


###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###










#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################