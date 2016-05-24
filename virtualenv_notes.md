# http://www.simononsoftware.com/virtualenv-tutorial-part-2/
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

#Fixes the prompt in a virtualenv.
#http://bewatermyfriend.org/p/2013/003/
# see also the documentation on GRML_theme_add_token_usage()
# add virtual-env to left_items of prompt_grml_precmd():
#   left_items=(rc virtual-env change-root user at host path vcs percent)
function virtual_env_prompt () {
    REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
}
grml_theme_add_token virtual-env -f virtual_env_prompt '%F{magenta}' '%f'

