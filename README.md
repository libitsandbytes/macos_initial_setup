# macOS System Configuration Script

A comprehensive shell script to quickly configure a fresh macOS installation with optimized settings for productivity and performance.

## Features

### 🗂️ Finder Configuration
- Sets default view to list view with optimized column layout
- Enables filename extensions, status bar, and path bar
- Configures sidebar and search settings
- Enables automatic trash cleanup (30 days)
- Removes .DS_Store files to reset folder view settings

### ⚡ Performance Optimization
- Reduces system animations and motion effects
- Disables unnecessary visual effects in Finder, Mail, and system UI
- Speeds up Mission Control, Launchpad, and Dock animations
- Improves overall system responsiveness
- Disables smooth scrolling and window animations

### 🧹 System Cleanup
- Disables Mission Control space rearrangement
- Turns off Apple Intelligence features
- Empties trash automatically
- Cleans up system files

### 📱 Application Installation
- **ProtonMail** - Secure email client
- **Rectangle** - Window management utility (latest version from GitHub)

## Usage

1. Download the script:
   ```
   curl -O https://raw.githubusercontent.com/yourusername/macos-setup/main/setup.sh

2. Make it executable:
   ```
   chmod +x setup.sh

3. Run the script:
   ```
   ./initial_setup_macos.sh

## Requirements

- macOS (tested on recent versions)
- Administrative privileges for some operations
- Internet connection for application downloads
- `curl` and `hdiutil` (included with macOS)

## What Changes Are Made

This script modifies system preferences and installs applications. The script provides verbose output so you can see exactly what's being configured at each step.

### System Preferences Modified
- Finder view settings and behavior
- Animation and motion settings
- Dock and Mission Control preferences
- Global UI behavior settings

### Applications Installed
- ProtonMail desktop application
- Rectangle window manager

## Important Notes

- **⚠️ Intended for fresh installations**: This script is designed for new macOS installations without personal files. If you're running it on a device with existing personal files, **create a backup first** as some files may be deleted during the cleanup process.
- **Review before running**: Check the script contents to ensure the changes match your preferences
- **Automatic restarts**: The script will restart Finder and Dock to apply changes
- **Temporary files**: Downloads are stored in a temporary directory and cleaned up automatically

## Customization

The script is modular and easy to customize. Each section is clearly marked with comments. You can:

- Comment out sections you don't want to run
- Modify application lists
- Adjust animation speeds and timing
- Change Finder view preferences

## Troubleshooting

If an application fails to install:
1. Check your internet connection
2. Verify the download URLs are still valid
3. Ensure you have sufficient disk space
4. Check the script output for specific error messages

## Contributing

Feel free to submit issues and pull requests to improve the script or add new applications and configurations.

## License

This project is open source and available under the [MIT License](LICENSE).
