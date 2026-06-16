#!/bin/bash
# Install cmux - macOS Terminal Multiplexer

set -e

echo "📦 Checking cmux..."

# Check if already installed
if [[ -d "/Applications/cmux.app" ]]; then
    echo "  ✅ cmux already installed"
    exit 0
fi

# Check Homebrew tap
if ! brew tap | grep -q "manaflow-ai/cmux"; then
    echo "📦 Adding cmux tap..."
    brew tap manaflow-ai/cmux
fi

# Install cmux
echo "📦 Installing cmux..."
brew install --cask cmux

echo "✅ cmux installation complete"
