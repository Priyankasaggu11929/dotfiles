# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="alfredo"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

virtual_envs=(/Users/adeza/python /opt/devel /Users/alfredo/python)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git django med pytest python)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/local/mysql/bin:/Users/adeza/bin:/Users/adeza/bin/google_appengine

# source IP's and private shortcuts
source ~/.zshrc-private

# I hate autocorrect
unsetopt correctall

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# go back!
alias cdd='cd -'

# cd aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."


#
# Function Time!
#

# change to python package directory
cdp() {
    cd $(python -c "import os.path as _, ${1}; print _.dirname(_.realpath(${1}.__file__))")
}

ssh-copy-key() {
    ssh ${1} "echo `cat ~/.ssh/id_rsa.pub` >> ~/.ssh/authorized_keys"
}



alias bitch='sudo '
alias ls='gls --color=if-tty'

export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

alias pg='ps aux | grep -v grep | grep $1'
alias pgi='ps aux | grep -v grep | grep -i $1'
alias \:q='exit'
alias cls='clear; ls'
alias Vimrc='mvim ~/.vimrc'
alias vimrc='vim ~/.vimrc'

# I hate you LDAP completion of usernames
zstyle ':completion:*' users {adeza,root,cmg}

# Build/Compile Correctly
export ARCHFLAGS="-arch i386 -arch x86_64"

# CMG specific
export DEVELDIR=/opt/devel
export CMG_LOCAL_VIRTUALENV_VERSION=1

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  NORMAL_MODE="%{$fg[yellow]%}n%{$reset_color%}"
  INSERT_MODE="%{$fg[cyan]%}i%{$reset_color%}"
fi

function zle-line-init zle-keymap-select {
 VIMODE="${${KEYMAP/vicmd/[$NORMAL_MODE]}/(main|viins)/[$INSERT_MODE]}"
 zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

bindkey -v

# Make sure Ctrl-R works
bindkey '^R' history-incremental-search-backward

# Make backspace work like vim
bindkey '^?' backward-delete-char

# When using arrows, match what I have already typed
# for history search
bindkey -M viins "\e[A" up-line-or-search    # Up arrow
bindkey -M viins "\e[B" down-line-or-search  # Down arrow
bindkey -M vicmd "k"    up-line-or-search
bindkey -M vicmd "j"    up-line-or-search

# Prompt
PROMPT='%{$fg[cyan]%}%n@mac $(git_prompt_info)%{$fg[yellow]%}%~ %{$reset_color%}${VIMODE}$ '
