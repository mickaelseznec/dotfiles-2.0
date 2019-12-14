if on_linux; then
    alias open="xdg-open"
fi

alias cpv="rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress"
alias rmf="rm -rf"
alias l="ls -lh"
alias ll="ls -lh"
alias la="ls -lhA"
alias zr='source ~/.zshrc'
alias zrc='vim ~/.zshrc'
alias grepr='grep -rn --exclude tags'   # Recursive, line number and case insensitive
alias tree='tree -C'                    # Colors
alias vrc='vim ~/.vimrc'
alias j="jobs -l"
alias gdb="gdb -q"

alias g="git"
alias v="vim"

if on_linux; then
    alias ls="ls --color=auto"
else
    export CLICOLOR
fi
alias grep="grep --color=auto --exclude-dir={.svn,.hg,.git}"
alias less="less -R"

alias _="sudo"
alias -- -="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias indent="vim -c 'norm =G' -c 'wq'"

alias gst="git status"
alias gci="git commit"
alias gbr="git branch"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias glg="git log -p"
alias gpr="git pull --rebase"
alias gp="git push"
alias gpl="git pull"
alias glol="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias glola="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias glatestf="gitor-each-ref --sort=-taggerdate --format='%(refname:short)' --count=1"
alias ga="git add"
alias gap="git add -p ."
alias gaa="git add -A"
alias gc="git commit -v"
alias gcp="git commit -v -p ."
alias gss="git stash"
alias gsp="git stash pop"
alias gl="git pull"
alias glr="git pull --rebase"
alias gmtv="git mergetool -t vimdiff"

if is_zsh; then
    alias -g L="| less"
    alias -g LL="2>&1 | less"
fi

if on_linux; then
    alias makep="make -j$(grep -c "processor" /proc/cpuinfo)"
else
    alias makep="make -j$(sysctl -n hw.ncpu)"
fi
