# Usage & Detailed Instructions

This document gives step-by-step instructions and examples for safely using FlattenFolder.command.

## 1 — Backup (required)

Before touching your original folder, create a backup copy:

- Terminal example:
  cp -a "/Users/you/Downloads/MySourceFolder" "/Users/you/Downloads/MySourceFolder.backup"

Confirm the backup exists and contains the files you expect before proceeding.

## 2 — Make the script executable

If you downloaded `FlattenFolder.command` to Downloads (default example):

chmod +x ~/Downloads/FlattenFolder.command

If you saved to another folder (adjust the path):

chmod +x /path/to/FlattenFolder.command

## 3 — Run the script

Option A — Double-click
- After `chmod +x`, double-click the `FlattenFolder.command` file in Finder. A Terminal window will open and run the script.

Option B — From Terminal (recommended for visibility)
- In Terminal:
  /path/to/FlattenFolder.command
- Example:
  ~/Downloads/FlattenFolder.command

Running from Terminal lets you see all log output and any error messages.

## 4 — Interactive selection with fzf

- The script lists subfolders under the default path and opens an `fzf` selection UI.
- Controls:
  - Arrow keys: move
  - Spacebar: select (single selection)
  - Enter: confirm selection

After confirmation the script moves files and cleans up empty directories.

## 5 — Changing defaults inside the script

Open the file to edit:

- Quick edit with nano:
  nano ~/Downloads/FlattenFolder.command

Look for variables (near the top) like:

DEFAULT_SOURCE="${HOME}/Downloads"
DESTINATION_DIR="${HOME}/Downloads/Flattened_Files"

Edit to your preferred absolute path and save.

- Example (set Desktop as default source and Documents/Flattened as destination):
  DEFAULT_SOURCE="${HOME}/Desktop"
  DESTINATION_DIR="${HOME}/Documents/Flattened_Files"

Save and exit, then ensure executable:
chmod +x /path/to/FlattenFolder.command

## 6 — Running for a different source without editing (advanced)

If you want to run the script against a folder in-place, you can:

- Move the script to the parent directory of the folder and double-click/run it there, if the script uses the current working directory as selection base.
- Or edit `DEFAULT_SOURCE` as described.

(If you need CLI argument support, we can update the script in a future release to accept `./FlattenFolder.command /path/to/source`.)

## 7 — What to watch for

- Duplicate filenames: The script uses `mv -n` to avoid overwriting. If two different files have the same basename, only the first moved will be moved; the later duplicate will remain in place.
- No undo: If you need to revert, use your backup copy.

## 8 — Example workflow (Desktop → gather into Documents/PhotosFlat)

1. Backup:
   cp -a ~/Desktop/PhotosProject ~/Desktop/PhotosProject.backup

2. Edit script:
   - Set DEFAULT_SOURCE="${HOME}/Desktop/PhotosProject"
   - Set DESTINATION_DIR="${HOME}/Documents/PhotosFlat"
   Save & chmod +x.

3. Run in Terminal:
   ~/Downloads/FlattenFolder.command
   (or /path/to/where/you/saved/FlattenFolder.command)

4. Confirm files were moved and that the backup is intact.

---

## 9 — Want a safer behavior?

If you'd like a safer "copy then delete" mode instead of moving:
- I can prepare a patch that copies files first, verifies success, and only then removes originals and empty directories.
- That feature would add time and disk usage but improve safety.

---

## 10 — Final warning

This software moves files and removes empty directories. There is no automatic undo. Use backups. Use at your own risk.

If you'd like, I can:
- Add CLI arguments for source/destination
- Add a "dry-run" mode that shows what would be moved without touching files
- Add a copy-then-verify mode to make the tool safer

Tell me which of these improvements you'd like and I can prepare updated documentation and a PR.
