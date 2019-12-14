on_linux() {
    [[ $(uname -s) == "Linux" ]]
}

is_zsh() {
    [[ -n $ZSH_NAME ]]
}

ss()
{
    >/dev/null 2>&1 nohup $@ &
}

s()
{
    >/dev/null 2>&1 $@ &
}

# Shortcut for mkdir + cd
mkcd()
{
    mkdir -p $1 && cd $1
}

prepend_path_unique()
{
    if [[ $PATH != *$1* ]]; then
        export PATH="$1:$PATH"
    fi
}

append_path_unique()
{
    if [[ $PATH != *$1* ]]; then
        export PATH="$PATH:$1"
    fi
}


# extract the files
extract()
{
    if [[ -z "$1" ]]; then
        print -P "usage: \e[1;36mextract\e[1;0m < filename >"
        print -P "       Extract the file specified based on the extension"
    elif [[ -f $1 ]]; then
        case ${(L)1} in
            *.tar.bz2)  tar -jxvf  $1;;
            *.tar.gz)   tar -zxvf  $1;;
            *.tar.xz)   tar -Jxvf  $1;;
            *.bz2)      bunzip2    $1;;
            *.gz)       gunzip     $1;;
            *.jar)      unzip      $1;;
            *.rar)      unrar x    $1;;
            *.tar)      tar -xvf   $1;;
            *.tbz2)     tar -jxvf  $1;;
            *.tgz)      tar -zxvf  $1;;
            *.zip)      unzip      $1;;
            *.Z)        uncompress $1;;
            *.7z)       7z x       $1;;
            *)          echo "Unable to extract '$1' :: Unknown extension"
        esac
    else
        echo "File ('$1') does not exist!"
    fi
}

ssh-init()
{
    if [ -z $SSH_AGENT_PID ]
    then
        eval $(ssh-agent -s)
    fi
    ssh-add -l > /dev/null || ssh-add
}

set_proxy_l2s() {
    PROXY_ENV=(http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY)
    for envar in $PROXY_ENV
    do
        export $envar="proxy.l2s.supelec.fr:8080"
    done
    NO_PROX=(no_proxy NO_PROXY)
    for envar in $NO_PROX
    do
        export $envar="localhost,127.0.0.1"
    done
}

set_proxy_thales() {
    PROXY_ENV=(http_proxy ftp_proxy all_proxy HTTP_PROXY FTP_PROXY ALL_PROXY)
    for envar in $PROXY_ENV
    do
        export $envar="http://$1:$2@proxy.theresis.org:80"
    done
    HTTPS_PROXY_ENV=(https_proxy HTTPS_PROXY)
    for envar in $HTTPS_PROXY_ENV
    do
        export $envar="http://$1:$2@proxy.theresis.org:3128"
    done

    NO_PROX=(no_proxy NO_PROXY)
    for envar in $NO_PROX
    do
        export $envar="localhost,127.0.0.1"
    done
}

unset_proxy() {
    PROXY_ENV=(http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY)
    for envar in $PROXY_ENV
    do
        unset $envar
    done
    unset no_proxy
    unset NO_PROXY
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

fo() {
  local out file key opener
  IFS=$'\n' out=($(fzf-tmux --query="$1" --exit-0 --expect=ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-e ] && ${EDITOR:-vim} "$file" || open "$file"
  fi
}


