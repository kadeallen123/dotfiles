# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kadeallen/.oh-my-zsh"
PATH="/Applications/CMake.app/Contents/bin":"$PATH"
source /Users/kadeallen/.ghcup/env

# Stop homebrew always updating before installing package
export HOMEBREW_NO_AUTO_UPDATE=1

# ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Plugins
plugins=(
    git
    zsh-interactive-cd
)

#ZSH_THEME="refined"
source $ZSH/oh-my-zsh.sh

# User configuration

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
#local user_symbol="$"
#if [[ $(print -P "%#") =~ "#" ]]; then
#    user_symbol = "#"
#fi
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kadeallen/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kadeallen/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kadeallen/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kadeallen/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fpath+=$HOME/.zsh/pure

#source ~/powerlevel10k/powerlevel10k.zsh-theme
#
autoload -Uz promptinit; promptinit
# prompt pure
#
## --- Aliases ---
alias t="tmux"
alias tls="tmux ls"
alias tn="t new -s "
alias ta="t attach -t"
alias tks="t kill-session -t"
alias tka="t kill-session -a"

alias ls="exa -l --sort=ext"

alias doomsync="~/.emacs.d/bin/doom sync"
alias psql="/Applications/Postgres.app/Contents/Versions/13/bin/psql"

alias emacscustom="emacs --with-profile custom"
alias emacsgui='$(/Applications/Emacs.app/Contents/MacOS/Emacs "$@")'

alias pjava='processing-java --sketch=$PWD --run'
alias cdtri='cd ~/School/2022/TRI\ 2/'

alias pn=pnpm
alias compilec='gcc -std=c99 -Wall -Wextra -Werror -O2 -pedantic'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

eval "$(starship init zsh)"

[ -f "/Users/kadeallen/.ghcup/env" ] && source "/Users/kadeallen/.ghcup/env" # ghcup-env

[ -f /usr/local/etc/bash_completion ] && ./usr/local/etc/bash_completion
# opam configuration
[[ ! -r /Users/kadeallen/.opam/opam-init/init.zsh ]] || source /Users/kadeallen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval "$(pyenv init -)"

