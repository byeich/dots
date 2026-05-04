# completion
[ -f /etc/bash_completion ] && source /etc/bash_completion
command -v kubectl &>/dev/null && source <(kubectl completion bash)
command -v helm    &>/dev/null && source <(helm completion bash)

# prompt
# $'\001'/'\002' are the bash-safe equivalents of \[ and \] inside variables
_update_ps1() {
  local RESET=$'\001\033[0m\002'
  local GREEN=$'\001\033[0;32m\002'
  local YELLOW=$'\001\033[0;33m\002'
  local BLUE=$'\001\033[0;34m\002'

  local branch git_part=""
  branch=$(git branch 2>/dev/null | grep '^\*' | sed 's/\* //')
  [ -n "$branch" ] && git_part=" (${BLUE}${branch}${RESET})"

  PS1="${GREEN}\u${RESET} ${YELLOW}\w${RESET}${git_part} \$ "
}
PROMPT_COMMAND="_update_ps1"

# misc
alias ll='ls -la'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'

# git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'

# kubectl
alias k='kubectl'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgp-a='kubectl get pods -A'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kns='kubectl config set-context --current --namespace'

# helm
alias h='helm'
alias hl='helm list -A'

# opentofu
alias tf='tofu'
alias tfi='tofu init'
alias tfp='tofu plan'
alias tfa='tofu apply'

# kubeseal — encrypt a secret for this cluster
# usage: kseal <secret.yaml> <namespace>
kseal() {
  kubeseal --format=yaml --namespace="${2:-default}" < "$1"
}

# show all pods sorted by node
alias kpbn='kubectl get pods -A -o wide --sort-by=.spec.nodeName'

# quick context/namespace display
alias kctx='kubectl config current-context'
alias kns-cur='kubectl config view --minify --output "jsonpath={..namespace}"'
