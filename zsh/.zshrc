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
