# Apple Flatten Folder Terminal Tool

Version: 0.0.01-alpha  
Author: Wayne Tech Lab LLC

Apple Flatten Folder is a small macOS terminal utility (a single shell script packaged as a `.command`) that moves files from nested subfolders into a single destination directory, removing empty subdirectories afterward. It uses `fzf` for interactive source selection and `mv -n` to skip duplicate filenames. This tool is provided for free, for advanced users, and must be used with extreme caution.

Important: Always backup your data before running this tool. There is no automatic undo.

---

## Quick summary (what it does and why it saves time)

- Collects all files from a folder tree into one flat destination folder.
- Useful for quickly gathering assets, images, documents or exported files that are scattered across subfolders.
- Saves time by removing the need to manually search nested folders and copy/move files one-by-one.
- Interactive selection (via `fzf`) lets you pick the source folder quickly.

---

## Safety & License (read carefully)

- USE AT YOUR OWN RISK. This is an alpha release (0.0.01-alpha).
- There is no "undo". Files are moved (not copied) and duplicate names are skipped (so some files may remain in place).
- ALWAYS make a backup of the source folder before running the script:
  - Example backup command:
    - cp -a "/path/to/SourceFolder" "/path/to/SourceFolder.backup"
- Provided "as is" by Wayne Tech Lab LLC.

---

## Prerequisites

- macOS Terminal (this is a shell script `.command` file).
- Homebrew and `fzf` are used by the script. The script checks/installs `fzf` if Homebrew is present.

---

## First step — make the script executable (chmod)

Before running the tool for the first time you must mark it executable. Example:

1. Save `FlattenFolder.command` into a folder (default instructions below assume the Downloads folder).
2. Open Terminal and run:

- If you saved to Downloads:
  chmod +x ~/Downloads/FlattenFolder.command

- If you saved elsewhere (example: Desktop):
  chmod +x ~/Desktop/FlattenFolder.command

After making it executable you can double-click the `.command` in Finder to launch it, or run it from Terminal.

---

## Default working directory

By default the script runs using your Downloads folder as the default source location (for example: `/Users/<your-username>/Downloads`). This is only a default; during runtime the script will list subfolders and let you choose a source directory using `fzf`.

If you want a different default source folder (for example, Desktop or a custom path) modify the script as described below.

---

## How to change the default source or destination in the script

Open `FlattenFolder.command` in a text editor (TextEdit in plain text mode, Visual Studio Code, nano, vim, etc.) and look near the top for the variables that set the default source/destination. Typical variable names and example edits:

Example lines you might find and change:

- Default source (change to Desktop):
  DEFAULT_SOURCE="${HOME}/Downloads"
  change to
  DEFAULT_SOURCE="${HOME}/Desktop"

- Default destination (change to a custom folder):
  DESTINATION_DIR="${HOME}/Downloads/Flattened_Files"
  change to
  DESTINATION_DIR="${HOME}/Documents/MyFlatFolder"

If those exact variable names are not present, look for the line that prints "Default source path is:" or any assignment using `$HOME/Downloads` and edit accordingly.

After editing, save the file and ensure it remains executable:
chmod +x /path/to/FlattenFolder.command

---

## How to save and run from a different location

Option A — Keep using the Downloads default:
- Save `FlattenFolder.command` to `~/Downloads`
- Make executable:
  chmod +x ~/Downloads/FlattenFolder.command
- Run (double-click in Finder) or from Terminal:
  ~/Downloads/FlattenFolder.command

Option B — Save to Desktop (or any folder) and run from there:
- Save `FlattenFolder.command` to `~/Desktop`
- Make executable:
  chmod +x ~/Desktop/FlattenFolder.command
- Run:
  ~/Desktop/FlattenFolder.command

Option C — Run against any arbitrary folder without changing the script:
- Move to the desired parent folder in Terminal, then run the script with a path argument (if the script supports arguments), or edit the default variable as described above. If the script doesn't accept CLI args, edit the `DEFAULT_SOURCE` variable inside the script to your desired path.

Tip: To run the script in Terminal so you can see errors and logs:
1. Open Terminal
2. Run:
   /path/to/FlattenFolder.command

---

## What to expect when you run the script

- Script prints a header: "--- Folder Flattener Utility ---"
- It checks Homebrew and `fzf`.
- It shows the default source path (you can navigate subfolders using `fzf` — arrows to move, Space to select, Enter to confirm).
- It reports:
  - Source directory chosen
  - Destination directory (default: ~/Downloads/Flattened_Files unless changed)
- It begins the move process and notes duplicate names will be skipped (it uses `mv -n`).
- It then removes empty subdirectories.
- Script ends and waits for you to press Enter before closing the Terminal window (if run by double-clicking).

Example messages from a run:
- "Source location verified: /Users/satoshiuno/Downloads/Al Weather App Mockup 2"
- "Starting file transfer... (Duplicate names will be skipped using mv -n)"
- "File transfer complete."
- "Removing empty subdirectories from source..."
- "--- Operation Finished ---"

---

## Common edits (examples)

- Change default source to Desktop:
  DEFAULT_SOURCE="${HOME}/Desktop"

- Change destination to a folder named FlatResults in Documents:
  DESTINATION_DIR="${HOME}/Documents/FlatResults"

- Change duplicate handling (advanced): find the `mv -n` call and change to `mv -b` or implement a rename strategy — only recommended if you know shell scripting.

---

## Troubleshooting

- Error: "read: -p: no coprocess" — this comes from the use of `read -p` inside a .command environment in some shells. Running the script from Terminal directly (instead of double-click) can avoid some interactive shell differences. If this appears, open Terminal and run the script by full path to see exact messages.

- If `fzf` installation fails: ensure Homebrew is installed and `brew` is available in your PATH.

---

## Changelog

- 0.0.01-alpha — Initial release (Wayne Tech Lab LLC). Provided free, use with extreme caution.

---

## Contact & contribution

Repository: [WayneTechLab/Apple-Tools-FlattenFolder](https://github.com/WayneTechLab/Apple-Tools-FlattenFolder)

If you want to suggest improvements (e.g., safer copy-then-delete workflow or undo support), open an issue or a pull request. Include your testing details and backup steps.
