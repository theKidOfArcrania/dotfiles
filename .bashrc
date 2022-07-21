# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias ssh-proxy='ssh -f -N -D 12345 -p 1001 104.131.79.111'

export DONT_PROMPT_WSL_INSTALL=1

if [ -v WSLENV ]; then
  LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
  export DISPLAY=$LOCAL_IP:0
fi

source ~/posh-git-sh/git-prompt.sh
#PATH=/usr/local/texlive/2018/bin/x86_64-linux/:$PATH:~/bin
PATH=$HOME/.local/bin/:$HOME/.cabal/bin/:$HOME/bin:$HOME/x-tools/arm-android-linux-gnueabi/bin:$HOME/.cargo/bin:$HOME/.stack/programs/x86_64-linux/ghc-tinfo6-8.8.3/bin/:/sbin:/usr/sbin:$PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
export PROMPT_COMMAND='__posh_git_ps1 "\[\e[0;32m\]\u@\h \[\e[0;33m\]\w " " \[\e[1;34m\]\n\$\[\e[0m\] ";'$PROMPT_COMMAND
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias chipw='chipw /usr/local/share/tworld/data/CCLP4.dat'
alias cs1='ssh hhw170030@cs1.utdallas.edu -D 7003 -C'
alias easyctf='ssh user46388@s.easyctf.com'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#eval $(thefuck --alias)
#alias fk=fuck

# Open terminal in previous directory
function cd {
  builtin cd "$@"
  echo $(pwd) > ~/.last_dir
}
if [ -f ~/.last_dir ]; then
  cd "`cat ~/.last_dir`"
fi

# Alias objdump with -M intel
alias objdump='objdump -M intel'

# Set nasmx paths
if [ -e /opt/nasmx-1.4 ]; then
  OLD_DIR=$(pwd)
  builtin cd /opt/nasmx-1.4; . ./setpaths.sh > /dev/null
  builtin cd "$OLD_DIR"
fi

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if which fzf > /dev/null 2> /dev/null; then
   source /usr/share/doc/fzf/examples/key-bindings.bash
   source /usr/share/doc/fzf/examples/completion.bash
fi


#alias vi=nvim
#alias vim=nvim
#alias vim8=/usr/bin/vim
alias hd="hexdump -C"

alias viminit="vim ~/.config/nvim/init.vim"

set -o vi

# OPAM configuration
if [ -e $HOME/.opam ]; then
  . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
fi

if [ -e $HOME/git/tacticalctf/docker/thispath ]; then
  source $HOME/git/tacticalctf/docker/thispath
fi

alias xgrep="grep --exclude-dir=dist --exclude-dir=node_modules --exclude-dir=ctfdist"


# Enables autocompletion of options for bashfuscator
#eval "$($HOME/.local/bin//register-python-argcomplete bashfuscator)"

# The next line updates PATH for the Google Cloud SDK.
if [ -e $HOME/Downloads/google-cloud-sdk ]; then
  if [ -f '$HOME/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '$HOME/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
  if [ -f '$HOME/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '$HOME/Downloads/google-cloud-sdk/completion.bash.inc'; fi
fi
if [ -e $HOME/.cargo/env ]; then
  source "$HOME/.cargo/env"
fi
