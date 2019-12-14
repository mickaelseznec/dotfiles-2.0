export EDITOR='vim'
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true
export FZF_DEFAULT_COMMAND='rg --files'

# Watch other user login/out
watch=notme
export LOGCHECK=60

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# History
##############################################################################
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
export REPORTTIME=30 # Say how long a command took, if it took more than 30 seconds

# Start ssh-agent if not present
[[ -z $SSH_AGENT_PID ]] && eval $(ssh-agent) > /dev/null
on_linux && setxkbmap -option caps:swapescape

if [[ $PATH != *"$HOME/.local/bin"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -n CONDA_PATH ]]; then
    __conda_setup="$(CONDA_REPORT_ERRORS=false "$CONDA_PATH/bin/conda" shell.bash hook 2> /dev/null)"
    if [ $? -eq 0 ]; then
        \eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PATH/etc/profile.d/conda.sh"
            CONDA_CHANGEPS1=false conda activate base
        else
            \export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# # Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"
