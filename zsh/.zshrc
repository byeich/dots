# prompt: ben ~/dev/dots (main) %
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%F{blue}%b%f)'
setopt PROMPT_SUBST
PROMPT='%F{green}%n%f %F{yellow}%~%f${vcs_info_msg_0_} %# '

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
