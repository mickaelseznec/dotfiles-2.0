source $HOME/dotfiles/shell/functions.zsh
source $HOME/dotfiles/shell/alias.zsh
source $HOME/dotfiles/shell/local.sh
source $HOME/dotfiles/shell/common.zsh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
