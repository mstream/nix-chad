unsetopt extended_glob
setopt ignoreeof
unalias -m '*'
bindkey -M vicmd "^D" down-history 
bindkey -M viins "^D" down-history 
bindkey -M vicmd "^U" up-history 
bindkey -M viins "^U" up-history 
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
