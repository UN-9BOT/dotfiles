# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# custom vars
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root)
export MAIL=un.9bot@gmail.com

# NVIM SETTINGS
export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
# fi
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     export VISUAL="nvim"
#     export EDITOR="nvim"
# fi

# alias v='nvim --listen /tmp/nvim-server-$(tmux display-message -p "#S").pipe'
# alias v="nvim --listen /tmp/nvim-server-$(tmux display-message -p '\#{session_id}-#{window_id}-#{pane_id}').pipe"

# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     alias vim='nvim --listen /tmp/nvim-server.pipe'
# fi



# ALIAS
alias v="nvim"
alias nv='neovide'
alias kn='killall nvim'
alias q='exit'
alias p='python'
alias pt='ipython'
alias yank='xclip -sel clip'
alias cat='ccat'
alias ls='exa --git'
alias rm='rm -I'
alias lg='lazygit'
alias ldr='lazydocker'
alias tm='tmux attach || tmux new -c "$PWD"'
alias c='clear'
alias bd='blobdrop'
alias task='go-task'
alias t='go-task'

alias mt='sh ~/.prog/mouse-follows-focus/toggle.sh'

mdcd () {
 mkdir "$1" && cd "$1"
}

# alias f='. ranger'
f() {
  tmp="$(mktemp)"
  yazi --cwd-file "$tmp" "$@"

  if [ -s "$tmp" ]; then
    dir="$(<"$tmp")"
    rm -f "$tmp"

    if [ "$dir" != "$(pwd)" ]; then
      cd "$dir" || return
    fi
  else
    rm -f "$tmp"
  fi
}

# ALIAS FOR RUN
alias wgu='sh ~/.config/scripts/run_DBS.sh'
alias wgd='sh ~/.config/scripts/kill_DBS.sh'


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
zsh-autosuggestions
zsh-syntax-highlighting
zsh-autocomplete
# dirhistory
history
autoswitch_virtualenv
httpie
cd-ls
dotbare
celery
# zsh-interactive-cd
# zsh-navigation-tools
)



source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Created by `pipx` on 2023-10-14 15:28:34
export PATH="$PATH:/home/vim9/.local/bin"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship init zsh)"


# zsh-autocomplete plug
zstyle ':completion:*:paths' path-completion yes
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# thefuck plug
eval $(thefuck --alias)

# remove duplicates in history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
