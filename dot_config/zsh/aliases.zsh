# ============================================
# Zsh Aliases Configuration
# ============================================

# ----- File Operations -----
alias mkdirp='mkdir -p'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# ----- Quick Edit -----
alias zshrc='${EDITOR} ~/.zshrc'
alias zshlocal='${EDITOR} ~/.config/zsh/local.zsh'
alias gitconfig='${EDITOR} ~/.gitconfig'

# ----- Development Tools -----
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ----- System Info -----
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -i -P | grep LISTEN'
alias mem='top -l 1 | grep PhysMem'

# ----- Quick Navigation -----
alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# ----- Git Shortcuts -----
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias glg='git lg'

# ----- Directory Listing -----
alias ls='eza 2>/dev/null || ls'
alias la='eza -a 2>/dev/null || ls -A'
