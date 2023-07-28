# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

#alias g='grep -in'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

alias afind='ack-grep -il'
alias p='ping ya.ru'

alias people='ssh -A 5.45.192.177'

alias vpnup='sudo openvpn --config /etc/openvpn/openvpn.conf'

alias emacs='vim'

alias suka='sudo'

alias copy='xclip -selection c'

alias arm='cd /arc; arc mount -m arcadia/ -S store/; cd -'
alias mm='cd /arc/arcadia/mds/mastermind/core'
alias mds='cd /arc/arcadia/mds'
alias salt='cd /arc/arcadia/admins/salt-media/storage'
# alias vim='/arc/arcadia/ya tool vim'
alias dctl='/arc/arcadia/ya tool dctl'
alias rebase='arc pull trunk; arc rebase trunk'
