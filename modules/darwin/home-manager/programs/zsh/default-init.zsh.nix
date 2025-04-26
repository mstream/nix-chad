# WARNING
# A lot of zsh initialization scripts assume default ZSH options.
# Be careful when manipulating them.
# Consider leaving them default and create ad-hoc preset functions which
# switch them when needed but only within the current ZSH session
# instead.
{ selectNextKey, selectPreviousKey }:
''
  setopt IGNORE_EOF
  unsetopt EXTENDED_GLOB
  unsetopt IGNORE_BRACES
  unsetopt KSH_ARRAYS
  unsetopt MAIL_WARNING

  function bash_compatibility_on()
  {
    setopt BANG_HIST
    setopt BASH_REMATCH
    setopt CHASE_LINKS
    setopt GLOB_DOTS
    setopt HASH_CMDS
    setopt PROMPT_SUBST

    unsetopt IGNORE_BRACES
  }

  function bash_compatibility_off()
  {
    setopt IGNORE_BRACES
    
    unsetopt BANG_HIST
    unsetopt BASH_REMATCH
    unsetopt CHASE_LINKS
    unsetopt GLOB_DOTS
    unsetopt HASH_CMDS
    unsetopt PROMPT_SUBST
  }

  unalias -m '*'

  bindkey -M vicmd "^${selectNextKey}" down-history 
  bindkey -M viins "^${selectNextKey}" down-history 
  bindkey -M vicmd "^${selectPreviousKey}" up-history 
  bindkey -M viins "^${selectPreviousKey}" up-history 

  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

  gpgconf --launch gpg-agent
''
