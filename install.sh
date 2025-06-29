#!/bin/bash

echo "Starting terminal setup installation..."

mkdir -p ~/.config/kitty
mkdir -p ~/.config/starship

echo "Copying kitty configuration..."
if [[ -f ./kitty/kitty.conf ]]; then
    cp ./kitty/kitty.conf ~/.config/kitty/
    echo "kitty.conf copied."
else
    echo "kitty.conf not found."
fi

if [[ -f ./kitty/theme.conf ]]; then
    cp ./kitty/theme.conf ~/.config/kitty/
    echo "theme.conf copied."
else
    echo "theme.conf not found."
fi

echo "Copying .zshrc file..."
if [[ -f ./zsh/.zshrc ]]; then
    cp ./zsh/.zshrc ~/.zshrc
    echo ".zshrc copied."
else
    echo ".zshrc not found."
fi

echo "Copying starship.toml..."
if [[ -f ./starship/starship.toml ]]; then
    cp ./starship/starship.toml ~/.config/starship/starship.toml
    echo "starship.toml copied."
else
    echo "starship.toml not found."
fi

echo "Checking for JetBrainsMono Nerd Font..."
if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    echo "Font not found. Attempting to install..."
    if command -v dnf &>/dev/null; then
        sudo dnf install -y jetbrains-mono-nf-fonts
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd
    elif command -v apt &>/dev/null; then
        sudo apt install -y fonts-jetbrains-mono
    else
        echo "Unsupported package manager. Please install the font manually."
    fi
else
    echo "Font is already installed."
fi

for pkg in kitty zsh starship; do
    if ! command -v $pkg &>/dev/null; then
        echo "$pkg is not installed. Please install it manually."
    else
        echo "$pkg is installed."
    fi
done

echo "Setup complete. Please restart your terminal to apply changes."

