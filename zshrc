source $HOME/.dotfiles/shell/functions.zsh
source $HOME/.dotfiles/shell/alias.zsh
source $HOME/.dotfiles/shell/local.sh
source $HOME/.dotfiles/shell/common.zsh
source $HOME/.dotfiles/shell/zsh_plugins.sh

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U colors && colors

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# emacs mode
bindkey -e

# fuzzy find: start to type
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey "$terminfo[cuu1]" up-line-or-beginning-search
bindkey "$terminfo[cud1]" down-line-or-beginning-search

# backward and forward word with option+left/right
bindkey '^[^[[D' backward-word
bindkey '^[b' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[f' forward-word

# to to the beggining/end of line with fn+left/right or home/end
bindkey "${terminfo[khome]}" beginning-of-line
bindkey '^[[H' beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[F' end-of-line

# delete char with backspaces and delete
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# delete word with ctrl+backspace
bindkey '^[[3;5~' backward-delete-word
# bindkey '^[[3~' backward-delete-word

# HISTORY options
setopt bang_hist                # use ! for history
setopt hist_allow_clobber       # if blocked by clobber, change it in history
setopt hist_find_no_dups        # don't no dups at all
setopt hist_ignore_dups         # don't write consecutive dups
setopt hist_ignore_space        # go anonymous by starting with a space
setopt hist_reduce_blanks       # trim
setopt hist_verify              # don't execute right away when doing history expension
setopt inc_append_history_time  # increment history with time per command

# don't nice background tasks
setopt no_bg_nice
setopt no_beep

# allow functions to have local options
setopt local_options

setopt prompt_subst
setopt correct
setopt complete_in_word

setopt auto_pushd
setopt pushd_ignore_dups

# Completion
zstyle ':completion:*' completer _oldlist _expand _complete _match _ignored _approximate

# matches case insensitive and substrings
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true

# colors in listing
if on_linux; then
    eval "$(dircolors -b)"
else
    eval "$(gdircolors -b)"
fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true

# menu if nb items > 2
zstyle ':completion:*' menu select=2

autoload -U compinit && compinit

# Named directories
hash -d w=$HOME/workspace
hash -d s=$HOME/dotfiles/shell

if [[ -d $HOME/Téléchargements ]]; then
    hash -d d=$HOME/Téléchargements
else
    hash -d d=$HOME/Downloads
fi

# Setup fzf
# ---------

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.dotfiles/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.dotfiles/fzf/shell/key-bindings.zsh"
