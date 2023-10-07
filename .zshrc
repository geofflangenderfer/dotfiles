# Use powerline
#
USE_POWERLINE="true"

bindkey -v
fpath=(
    ~/.zsh/funcs
    "${fpath[@]}"
)

# load autojump on macos
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u


export XDG_CONFIG_HOME=$HOME/.config

export EDITOR=nvim
export VISUAL=nvim

function mcd() { mkdir -p "$1" && cd "$1";}

alias ls='ls --color -rt'

alias vim=nvim

vimrc() {
    vim ~/.config/nvim/init.lua
}
zshrc() {
    vim ~/.zshrc
}
cwd() {
    pwd
    pwd | pbcopy
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# what does this do?
# fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
# prompt pure


# what is this for?
# eval "$(direnv hook zsh)"
# ~/.zshrc

eval "$(starship init zsh)"

vim_find() {
    vim $(find -iregex ".*$1.*" | fzf)
}
log() {
    git log --stat --oneline $1
}
typescript_ctags() {
    ctags -R --languages=TypeScript,HTML,CSS,JavaScript --exclude=dist
}

rails_ctags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=tmp . $(bundle list --paths)
}

oc() {
    git ls-files | xargs wc -l
}

# load brew into path
eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fpath+=${ZDOTDIR:-~}/.zsh_functions

# on macos, you can't modify files at /usr/bin
# a workaround is to: 
# - place file at /usr/local/bin
# - place /usr/local/bin before /usr/bin in the PATH
export PATH="/usr/local/bin:$PATH"
