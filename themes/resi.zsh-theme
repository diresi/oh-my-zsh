zstyle ':completion:*' special-dirs true

# stolen from some other theme
#
# Theme with full path names and hostname
# Handy if you work on different servers all the time;
PROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%m:%{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

# stolen from sunrise.zsh-theme
local return_code="%(?..%{$fg[red]%}%? :(%{$reset_color%})"
RPS1="${return_code}"

# stolen from grml-zsh-config
function grml-zsh-fg() {
  if (( ${#jobstates} )); then
    zle .push-input
    [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
    BUFFER="${BUFFER}fg"
    zle .accept-line
  else
    zle -M 'No background jobs. Doing nothing.'
  fi
}
zle -N grml-zsh-fg

function zrcgotwidget() {
    (( ${+widgets[$1]} ))
}

function zrcbindkey() {
    if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
        bindkey "$@"
    fi
}

function bind2maps () {
    local i sequence widget
    local -a maps

    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    if [[ "$1" == "-s" ]]; then
        shift
        sequence="$1"
    else
        sequence="${key[$1]}"
    fi
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        zrcbindkey -M "$i" "$sequence" "$widget"
    done
}

bind2maps emacs viins       -- -s '^z' grml-zsh-fg
# done with grml stuff
