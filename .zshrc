# Use powerline
#
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
#if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
#  source /usr/share/zsh/manjaro-zsh-prompt
#fi

bindkey -v
# edit command line vi
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
fpath=(
    ~/.zsh/funcs
    "${fpath[@]}"
)

# autojump config
# this file doesn't exist
# [[ -s /home/g/.autojump/etc/profile.d/autojump.zsh ]] && source /home/g/.autojump/etc/profile.d/autojump.zsh
# https://github.com/wting/autojump/issues/574#issuecomment-1272919033
[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh

autoload -U compinit && compinit -u


export XDG_CONFIG_HOME=$HOME/.config

export EDITOR=nvim
export VISUAL=nvim

# opam configuration
test -r /home/g/.opam/opam-init/init.zsh && . /home/g/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/g/.sdkman"
[[ -s "/home/g/.sdkman/bin/sdkman-init.sh" ]] && source "/home/g/.sdkman/bin/sdkman-init.sh"
function mcd() { mkdir -p "$1" && cd "$1";}
source /usr/share/nvm/init-nvm.sh

# source conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

alias ls='ls --color -rt'
alias open='mimeopen -n $1 2> /dev/null'
# fix tex install
# https://wiki.archlinux.org/index.php/TeX_Live
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

export TEXMFCNF='/usr/local/texlive/2021/texmf-dist/web2c:'
alias c='xclip -sel clip'
alias vim=nvim

vimrc() {
    vim ~/.config/nvim/init.lua
}
zshrc() {
    vim ~/.zshrc
}
cwd() {
    pwd
    pwd | xclip -sel clip
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export PATH="/home/g/.local/share/gem/ruby/3.0.0/bin:$PATH"
# export PATH="$PATH:/home/g/.local/share/coursier/bin"
# export PATH="/home/g/.local/share/solana/install/active_release/bin:$PATH"
PATH="/home/g/.local/share/solana/install/active_release/bin:/home/g/.cargo/bin:$PATH"
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure


if [ -e /home/g/.nix-profile/etc/profile.d/nix.sh ]
then
    . /home/g/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer

eval "$(direnv hook zsh)"

vim_find() {
    vim $(find -iregex ".*$1.*" | fzf)
}
log() {
    git log --stat --oneline $1
}
rails_ctags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log --exclude=tmp . $(bundle list --paths)
}

oc() {
    git ls-files | xargs wc -l
}

loi_template() {
    name=$1
    total=$2
    dp=$((0.1*$total))
    loan=$((0.9*$total))
    message="Hi $name, you've built an amazing product that has been useful to so many. Very impressive.

My vision for Purlem is to keep everything as constant as possible for customers. But, add some new AI tools to the campaign creation process. Customers hate user interface changes, so I'll try to keep that to a minimum.

I'd like to make an offer:
- \$$dp down payment
- \$$loan seller financed loan:
    - 3 year loan term
    - 6% interest
    - 36 monthly payments of $[1]
- if I default on the loan, I return Purlem to you. I don't plan on this to happen. It's insurance to secure your loan.

Receiving monthly payments instead of a lump sum should reduce your tax burden by reducing capital gains tax.

[1]: https://www.calculator.net/loan-calculator.html?cloanamount=$loan&cloanterm=3&cloantermmonth=0&cinterestrate=6&ccompound=annually&cpayback=month&x=Calculate&type=1#amortized-result
"
    echo $message
}

[ -f "/home/g/.ghcup/env" ] && source "/home/g/.ghcup/env" # ghcup-env
# install rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
