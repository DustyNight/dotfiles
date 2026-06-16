#!/bin/bash
# Chezmoi script: Initialize nvim (LazyVim)

set -e

echo "📝 Checking nvim configuration..."

# Check if nvim is installed
if ! command -v nvim &>/dev/null; then
    echo "⚠️  nvim not installed, skipping configuration"
    exit 0
fi

# Check if already initialized
if [[ -d ~/.local/share/nvim/lazy ]]; then
    echo "✅ LazyVim already initialized"
    exit 0
fi

echo "📝 Initializing LazyVim..."
echo "   Plugins will be automatically installed on first nvim launch"
echo "   Run: nvim"
echo "   Then wait for plugin installation to complete"

# Optional: Auto-install base plugins
# nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo "✅ nvim configuration deployed"
