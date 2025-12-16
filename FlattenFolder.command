#!/bin/zsh

# --- Configuration ---
DEFAULT_PATH="/Users/satoshiuno/Downloads"
DEST_FOLDER_NAME="Flattened_Files"
# ---------------------

echo "--- Folder Flattener Utility ---"

# --- Step 1: Automated Installation/Check for Homebrew and fzf ---

# Function to check and install Homebrew
install_homebrew() {
    echo "Homebrew not found. Starting installation..."
    # Check for Xcode command line tools first (Homebrew prerequisite)
    xcode-select --install
    # Run the official Homebrew install script non-interactively where possible
    /bin/bash -c "$(curl -fsSL raw.githubusercontent.com)"

    # Add Homebrew to PATH automatically for the current session and zshrc file
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew installed and configured for Zsh."
}

# Function to check and install fzf
install_fzf() {
    echo "'fzf' not found. Installing via Homebrew..."
    brew install fzf
    # Run the fzf installer script to set up keybindings and completion
    # This might prompt for confirmation, so we run it interactively
    echo "Running fzf shell integration script..."
    $(brew --prefix)/opt/fzf/install --all
    echo "fzf installed and configured."
}

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    install_homebrew
else
    echo "Homebrew already installed. Checking 'fzf'..."
    # Ensure brew is in PATH if it was just installed in a previous run
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Check for fzf
if ! command -v fzf &> /dev/null; then
    install_fzf
else
    echo "'fzf' already installed. Proceeding..."
fi

# ----------------------------------------------------------------

echo ""
echo "Default source path is: $DEFAULT_PATH"

# --- Step 2: Interactive Folder Selection ---

# Ask user if they want to change the default path
read -p "Do you want to use a different source path? (y/N): " change_path_choice

if [[ "$change_path_choice" =~ ^[Yy]$ ]]; then
    # Use graphical dialog to choose a different path
    source_dir=$(osascript -e 'tell app "Finder" to POSIX path of (choose folder with prompt "Select the folder you want to flatten:")')
    if [ -z "$source_dir" ]; then
        echo "No folder selected. Exiting."
        read
        exit 1
    fi
else
    # Use default path, ask for subfolder name using fzf
    echo "Listing subfolders in $DEFAULT_PATH."
    echo "Use arrows to navigate, Spacebar to select (1 item only), Enter to confirm:"

    selected_folder_base_name=$(find "$DEFAULT_PATH" -maxdepth 1 -type d ! -name '.' -exec basename {} \; | fzf --height 40% --prompt="Select one subfolder: ")

    if [ -z "$selected_folder_base_name" ]; then
        echo "No subfolder selected. Exiting."
        read
        exit 1
    fi

    source_dir="$DEFAULT_PATH/$selected_folder_base_name"
    
    if [ ! -d "$source_dir" ]; then
        echo "Error: $source_dir not found or is not a directory."
        read
        exit 1
    fi
    echo "Source location verified: $source_dir"
fi

# --- Step 3: Flatten Files ---

# Define the destination folder
parent_dir=$(dirname "$source_dir")
dest_dir="$parent_dir/$DEST_FOLDER_NAME"
mkdir -p "$dest_dir"

echo "--- Action Summary ---"
echo "Source directory: $source_dir"
echo "Destination directory: $dest_dir"
echo "----------------------"
echo "Starting file transfer... (Duplicate names will be skipped using mv -n)"

# Move all files
find "$source_dir" -type f -exec mv -n '{}' "$dest_dir/" \;

echo "File transfer complete."

# Clean up empty directories
echo "Removing empty subdirectories from source..."
find "$source_dir" -type d -empty -delete

echo "--- Operation Finished ---"
echo "Press Enter to close this window."
read
