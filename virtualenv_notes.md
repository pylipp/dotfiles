# Fix matplotlib not showing figures (http://www.pyimagesearch.com/2015/08/24/resolved-matplotlib-figures-not-showing-up-or-displaying/)
echo "backend: TkAgg" >> ~/.config/matplotlib/matplotlibrc
sudo apt-get install tcl-dev tk-dev python-tk python3-tk
workon <virtualenvname>
pip install --no-cache-dir matplotlib
python -c "import matplotlib; matplotlib.use('TkAgg')"

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

