#!/usr/bin/env sh

printf '%s\n' '[INFO] Loading public::variables'

###############################################################################################
###################################### PUBLIC VARIABLES #######################################
###############################################################################################

###-----------------------------------------------------------------------------------------###
###--- GENERAL -----------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

export CLICOLOR=1 # Activate terminal colors



###-----------------------------------------------------------------------------------------###
###--- HOMEBREW ----------------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###

if command -v brew >/dev/null 2>&1; then
  # From install (Output from: /opt/homebrew/bin/brew shellenv)
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
  export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
  export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"
  # Added configurations
  export HOMEBREW_AUTOREMOVE=true
  export HOMEBREW_CLEANUP_MAX_AGE_DAYS=7
  export HOMEBREW_COLOR=true
  export HOMEBREW_DISPLAY_INSTALL_TIMES=true
fi



###-----------------------------------------------------------------------------------------###
###--- <NEW SECTION> -----------------------------------------------------------------------###
###-----------------------------------------------------------------------------------------###




#################################################################################################
printf '\033[1A'; printf '\033[K'  ##############################################################
#################################################################################################


