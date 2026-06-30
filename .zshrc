# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


######################################################################
#                         🛠️ ENVIRONMENT SETUP                       #
######################################################################

export ZSH_THEME="powerlevel10k/powerlevel10k"
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/ig-linux-x86_64-0.12.0-dev.3533+e5d900268:$PATH"
export PATH="/opt/nvim-linux64/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmux-session-wizard/bin:$PATH"
export PATH="$HOME/.cargo/env:$HOME/.nvm/versions/node/v20.19.2/bin:$HOME/.local/bin/env:/usr/local/go/bin:$PATH"

source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
export MANPATH=$HOME/local/share/man:$MANPATH

export GIT_EDITOR=nvim
export EDITOR=nvim
export LC_ALL="en_US.utf8"
export GPG_TTY=$(tty)


bindkey '^p' history-search-backward
bindkey '^n' history-search-forward



### zsh History
# HISTZISE=5000
# HISTFILE=/.zsh_history
# SAVEDHIST=$HISTZISE
# HISTDUP=erase 


######################################################################
#                         🧠 TOOLING CONFIG                          #
######################################################################

### >>> NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

### >>> FZF & FD

export BAT_THEME="Visual Studio Dark+"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

### >>> FZF Theme Customization
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

### >>> FZF Git
source ~/fzf-git.sh/fzf-git.sh
_fzf_compgen_path()  { fd --hidden --exclude .git . "$1"; }
_fzf_compgen_dir()   { fd --type=d --hidden --exclude .git . "$1"; }

_fzf_comprun() {
  local command=$1; shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


### >>> Kubernetes Autocomplete
source <(kubectl completion zsh)

######################################################################
#                            🔗 ALIASES                              #
######################################################################

alias vi=nvim
alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias y=yazi
alias cat='bat --paging never --theme="Visual Studio Dark+"'
alias mux=tmuxinator
alias k=kubectl
alias e=eksctl
alias tm="$HOME/tmux-session.sh && tm"
alias ls='ls --color'

######################################################################
#                     ⚡ CUSTOM FUNCTIONS & SESH                     #
######################################################################

function sesh-sessions() {
  exec </dev/tty
  exec <&1
  local session
  session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
  [[ -z "$session" ]] && return
  sesh connect $session
}
zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

######################################################################
#                         🚀 OH-MY-ZSH PLUGINS                       #
######################################################################

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-vi-mode
  command-not-found
  zsh-bat
)
source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/santosh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/santosh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
fpath=($fpath ~/.zsh/completion)
export PATH="$HOME/.local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/santosh/google-cloud-sdk/path.zsh.inc' ]; then . '/home/santosh/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/santosh/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/santosh/google-cloud-sdk/completion.zsh.inc'; fi

# opencode
export PATH=/home/santosh/.opencode/bin:$PATH

eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

