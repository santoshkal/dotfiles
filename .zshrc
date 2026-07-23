# =============================================================================
# Powerlevel10k Instant Prompt
# =============================================================================

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Oh My Zsh
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
  zsh-vi-mode
  command-not-found
  zsh-bat
)

# =============================================================================
# PATH
# =============================================================================

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.tmux/plugins/tmux-session-wizard/bin:$PATH"
export PATH="$HOME/ig-linux-x86_64-0.12.0-dev.3533+e5d900268:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/opt/nvim-linux64/bin:$PATH"

# NVM node
export PATH="$HOME/.nvm/versions/node/v20.19.2/bin:$PATH"

# =============================================================================
# Environment Variables
# =============================================================================

export EDITOR=nvim
export GIT_EDITOR=nvim
export LC_ALL="en_US.utf8"
export GPG_TTY=$(tty)

export BAT_THEME="Visual Studio Dark+"

export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export MANPATH="$HOME/local/share/man:$MANPATH"

# =============================================================================
# History Navigation
# =============================================================================

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' zsh-history-substring-search-up
bindkey '^[[B' zsh-history-substring-search-down

# =============================================================================
# NVM
# =============================================================================

export NVM_DIR="$HOME/.nvm"

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# =============================================================================
# FZF
# =============================================================================

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"

fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# =============================================================================
# FZF Git
# =============================================================================

source "$HOME/fzf-git.sh/fzf-git.sh"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)
            fzf --preview 'eza --tree --color=always {} | head -200' "$@"
            ;;
        export|unset)
            fzf --preview "eval 'echo \${}'" "$@"
            ;;
        ssh)
            fzf --preview 'dig {}' "$@"
            ;;
        *)
            fzf --preview "$show_file_or_dir_preview" "$@"
            ;;
    esac
}

# =============================================================================
# Kubernetes
# =============================================================================

source <(kubectl completion zsh)

# =============================================================================
# Aliases
# =============================================================================

alias vi=nvim
alias v='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias y=yazi
alias cat='bat --paging never --theme="Visual Studio Dark+"'
alias mux=tmuxinator
alias k=kubectl
alias e=eksctl
alias tm="$HOME/tmux-session.sh && tm"
alias ls='ls --color'

# =============================================================================
# sesh
# =============================================================================

function sesh-sessions() {
    exec </dev/tty
    exec <&1

    local session

    session=$(sesh list -t -c |
        fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')

    [[ -z "$session" ]] && return

    sesh connect "$session"
}

zle -N sesh-sessions

bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

# =============================================================================
# Oh My Zsh
# =============================================================================

source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# Powerlevel10k
# =============================================================================

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =============================================================================
# Pyenv
# =============================================================================

export PYENV_ROOT="$HOME/.pyenv"

if [[ -d "$PYENV_ROOT/bin" ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
fi

if command -v pyenv >/dev/null; then
    eval "$(pyenv init - zsh)"
fi

# =============================================================================
# Google Cloud SDK
# =============================================================================

if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# =============================================================================
# Misc
# =============================================================================

fpath=($fpath ~/.zsh/completion)

eval "$(fzf --zsh)"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
