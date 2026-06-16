# ============================================
# Tool Configurations
# ============================================

# ----- Volta (Node Manager) -----
if [[ -d "$HOME/.volta" ]]; then
    export VOLTA_HOME="$HOME/.volta"
fi

# ----- Bun -----
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
fi

# ----- Cargo -----
if [[ -d "$HOME/.cargo" ]]; then
    source "$HOME/.cargo/env" 2>/dev/null || true
fi

# ----- jenv Auto JAVA_HOME -----
_jenv_auto_java_home() {
    local version_file
    version_file=$(jenv version-file 2>/dev/null)
    if [[ -n "$version_file" ]]; then
        local jenv_version
        jenv_version=$(cat "$version_file" 2>/dev/null)
        if [[ -n "$jenv_version" ]]; then
            export JAVA_HOME="$(jenv javahome 2>/dev/null)"
        fi
    fi
}
command -v jenv &>/dev/null && _jenv_auto_java_home

# ----- fzf Config -----
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f -not -path "*/\.*"'

# ----- Atuin Config -----
export ATUIN_NOBIND="true"  # Don't bind default shortcuts, manual bind

# ----- Chezmoi Shortcuts -----
alias cz='chezmoi'
alias czd='chezmoi diff'
alias cza='chezmoi apply'
alias cze='chezmoi edit'
alias czs='chezmoi status'
