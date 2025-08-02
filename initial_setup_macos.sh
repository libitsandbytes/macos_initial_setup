#!/bin/bash

# Prevent Mac from turning on when opening its lid or connecting to a power source
sudo nvram BootPreference=%00

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Zurich" > /dev/null

###################################################
#                                                 #
#               Dock Settings                     #
#                                                 #
###################################################

echo "Configuring Dock settings..."

# Move dock to the bottom
defaults write com.apple.dock orientation -string "bottom"

# Disable magnification
defaults write com.apple.dock magnification -bool false

# Disable "Show suggested and recent apps in Dock"
defaults write com.apple.dock show-recents -bool false

# Enable "Show indicators for open applications"
defaults write com.apple.dock show-process-indicators -bool true

# Enable "Animate opening applications"
defaults write com.apple.dock launchanim -bool true

# Set "Minimise windows using" to "Scale Effect"
defaults write com.apple.dock mineffect -string "scale"

# Disable "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool false

# Set icon size to 62 pixels
defaults write com.apple.Dock tilesize -int 62

# Fix Missions control to NEVER rearrange spaces
defaults write com.apple.dock mru-spaces -bool false

###################################################
#                                                 #
#          Enable-Disable features                #
#                                                 #
###################################################

# Disable autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable crash reporter
defaults write com.apple.CrashReporter DialogType none

# Disable save into iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Deactivate Apple Intelligence
defaults write com.apple.CloudSubscriptionFeatures.optIn "545129924" -bool "false"

# Set default screenshot location to Downloads.
defaults write com.apple.screencapture "location" -string "~/Downloads" && killall SystemUIServer

#Set screenshots image format to jpg
defaults write com.apple.screencapture "type" -string "jpg"

###################################################
#                                                 #
#              Power Management                   #
#                                                 #
###################################################

# Sleep the display after 60 minutes
sudo pmset -a displaysleep 60

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
sudo pmset -a hibernatemode 3

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###################################################
#                                                 #
#          Finder Configuration                   #
#                                                 #
###################################################

echo "Configuring Finder settings..."

# Set the default Finder view to list view
echo "Setting default Finder view to list view..."
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Configure list view settings for all folders
echo "Configuring list view settings..."
defaults write com.apple.finder FK_StandardViewSettings -dict-add ListViewSettings '{ "columns" = ( { "ascending" = 1; "identifier" = "name"; "visible" = 1; "width" = 300; }, { "ascending" = 0; "identifier" = "dateModified"; "visible" = 1; "width" = 181; }, { "ascending" = 0; "identifier" = "size"; "visible" = 1; "width" = 97; } ); "iconSize" = 16; "showIconPreview" = 0; "sortColumn" = "name"; "textSize" = 12; "useRelativeDates" = 1; }'

# Clear existing folder view settings to force use of default settings
echo "Clearing existing folder view settings..."
defaults delete com.apple.finder FXInfoPanesExpanded 2>/dev/null || true
defaults delete com.apple.finder FXDesktopVolumePositions 2>/dev/null || true

# Set list view for all view types
defaults write com.apple.finder FK_StandardViewSettings -dict-add ExtendedListViewSettings '{ "columns" = ( { "ascending" = 1; "identifier" = "name"; "visible" = 1; "width" = 300; }, { "ascending" = 0; "identifier" = "dateModified"; "visible" = 1; "width" = 181; }, { "ascending" = 0; "identifier" = "size"; "visible" = 1; "width" = 97; } ); "iconSize" = 16; "showIconPreview" = 0; "sortColumn" = "name"; "textSize" = 12; "useRelativeDates" = 1; }'

# Sets default search scope to the current folder
echo "Setting default search scope to current folder..."
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Remove trash items older than 30 days
echo "Enabling automatic trash cleanup..."
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

# Remove .DS_Store files to reset folder view settings
echo "Cleaning up .DS_Store files..."
find ~ -name ".DS_Store" -type f -delete 2>/dev/null || true

# Show all filename extensions
echo "Enabling filename extensions display..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set the sidebar icon size to small
echo "Setting sidebar icon size to small..."
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Show status bar in Finder
echo "Enabling Finder status bar..."
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar in Finder
echo "Enabling Finder path bar..."
defaults write com.apple.finder ShowPathbar -bool true

# Clean up Finder's sidebar
echo "Configuring Finder sidebar..."
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool false

# Hide internal hard drives on desktop
$ defaults write com.apple.Finder ShowHardDrivesOnDesktop -bool false

# Hide external hard drives on desktop
$ defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool false

# Hide removable media on desktop
$ defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool false

# Hide mounted servers on desktop
$ defaults write com.apple.Finder ShowMountedServersOnDesktop -bool false

# Restart Finder to apply changes
echo "Restarting Finder to apply changes..."
killall Finder

echo "Finder has been configured successfully."

###################################################
#                                                 #
#   Reducing motion and animations on macOS...    #
#                                                 #
###################################################

echo "Reducing motion and animations..."

# Reduce motion in Accessibility settings (most effective)
echo "Enabling reduce motion in Accessibility..."
defaults write com.apple.universalaccess reduceMotion -bool true

# Disable window animations
echo "Disabling window animations..."
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Speed up window resize animations
echo "Speeding up window resize animations..."
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable smooth scrolling
echo "Disabling smooth scrolling..."
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

# Disable animation when opening a Quick Look window
echo "Disabling Quick Look animations..."
defaults write -g QLPanelAnimationDuration -float 0

# Disable animation when opening the Info window in Finder
echo "Disabling Finder Info window animations..."
defaults write com.apple.finder DisableAllAnimations -bool true

# Speed up Mission Control animations
echo "Speeding up Mission Control animations..."
defaults write com.apple.dock expose-animation-duration -float 0.1

# Speed up Launchpad animations
echo "Speeding up Launchpad animations..."
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1

 # Disable dock hiding animation
echo "Disabling dock hiding animations..."
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock autohide-delay -float 0

# Disable zoom animation when focusing on text input fields
echo "Disabling text input field zoom animation..."
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Restart Dock to apply changes
echo "Restarting Dock to apply changes..."
killall Dock

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Show Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###################################################
#                                                 #
#                 Mac App Store                   #
#                                                 #
###################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Disable auto download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 0

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###################################################
#                                                 #
#           Application Installation              #
#                                                 #
###################################################

echo "Starting application downloads and installations..."

# Create temporary directory for downloads
TEMP_DIR=$(mktemp -d)
echo "Using temporary directory: $TEMP_DIR"

# Download and install ProtonMail
echo "Downloading ProtonMail..."
curl -L -o "$TEMP_DIR/ProtonMail-desktop.dmg" "https://proton.me/download/mail/macos/ProtonMail-desktop.dmg"

if [ $? -eq 0 ]; then
    echo "Installing ProtonMail..."
    hdiutil attach "$TEMP_DIR/ProtonMail-desktop.dmg" -quiet
    
    # Find the actual volume name and app name
    PROTON_VOLUME=$(ls /Volumes/ | grep -i proton | head -1)
    PROTON_APP=$(ls "/Volumes/$PROTON_VOLUME/" | grep -E "\.app$" | head -1)
    
    if [ -n "$PROTON_VOLUME" ] && [ -n "$PROTON_APP" ]; then
        cp -R "/Volumes/$PROTON_VOLUME/$PROTON_APP" "/Applications/"
        hdiutil detach "/Volumes/$PROTON_VOLUME" -quiet
        echo "ProtonMail installed successfully."
    else
        echo "Failed to locate ProtonMail app in mounted volume."
        hdiutil detach "/Volumes/$PROTON_VOLUME" -quiet 2>/dev/null || true
    fi
else
    echo "Failed to download ProtonMail."
fi

# Get latest Rectangle version and download URL
echo "Checking latest Rectangle version..."
RECTANGLE_LATEST=$(curl -s "https://api.github.com/repos/rxhanson/Rectangle/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
RECTANGLE_VERSION=$(echo $RECTANGLE_LATEST | sed 's/^v//')
RECTANGLE_URL="https://github.com/rxhanson/Rectangle/releases/download/$RECTANGLE_LATEST/Rectangle$RECTANGLE_VERSION.dmg"

echo "Downloading Rectangle..."

curl -L -o "$TEMP_DIR/Rectangle.dmg" "$RECTANGLE_URL"

if [ $? -eq 0 ]; then
    echo "Installing Rectangle..."
    hdiutil attach "$TEMP_DIR/Rectangle.dmg" -quiet
    
    # Find the actual volume name and app name
    RECTANGLE_VOLUME=$(ls /Volumes/ | grep -i rectangle | head -1)
    RECTANGLE_APP=$(ls "/Volumes/$RECTANGLE_VOLUME/" | grep -E "\.app$" | head -1)
    
    if [ -n "$RECTANGLE_VOLUME" ] && [ -n "$RECTANGLE_APP" ]; then
        cp -R "/Volumes/$RECTANGLE_VOLUME/$RECTANGLE_APP" "/Applications/"
        hdiutil detach "/Volumes/$RECTANGLE_VOLUME" -quiet
        echo "Rectangle installed successfully."
    else
        echo "Failed to locate Rectangle app in mounted volume."
        hdiutil detach "/Volumes/$RECTANGLE_VOLUME" -quiet 2>/dev/null || true
    fi
else
    echo "Failed to download Rectangle."
fi

# Get latest Signal Messenger version and download URL
echo "Checking latest Signal Messenger version..."
SIGNAL_LATEST=$(curl -s "https://api.github.com/repos/signalapp/Signal-Desktop/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
SIGNAL_VERSION=$(echo $SIGNAL_LATEST | sed 's/^v//')
SIGNAL_URL="https://updates.signal.org/desktop/signal-desktop-mac-universal-$SIGNAL_VERSION.dmg"

echo "Downloading Signal Messenger..."

curl -L -o "$TEMP_DIR/Signal.dmg" "$SIGNAL_URL"

if [ $? -eq 0 ]; then
    echo "Installing Signal Messenger..."
    hdiutil attach "$TEMP_DIR/Signal.dmg" -quiet
    
    # Find the actual volume name and app name
    SIGNAL_VOLUME=$(ls /Volumes/ | grep -i signal | head -1)
    SIGNAL_APP=$(ls "/Volumes/$SIGNAL_VOLUME/" | grep -E "\.app$" | head -1)
    
    if [ -n "$SIGNAL_VOLUME" ] && [ -n "$SIGNAL_APP" ]; then
        cp -R "/Volumes/$SIGNAL_VOLUME/$SIGNAL_APP" "/Applications/"
        hdiutil detach "/Volumes/$SIGNAL_VOLUME" -quiet
        echo "Signal Messenger installed successfully."
    else
        echo "Failed to locate Signal Messenger app in mounted volume."
        hdiutil detach "/Volumes/$SIGNAL_VOLUME" -quiet 2>/dev/null || true
    fi
else
    echo "Failed to download Signal Messenger."
fi

# Download and install Bitwarden
echo "Downloading Bitwarden..."
curl -L -o "$TEMP_DIR/Bitwarden.dmg" "https://bitwarden.com/download/?app=desktop&platform=macos&variant=dmg"

if [ $? -eq 0 ]; then
    echo "Installing Bitwarden..."
    hdiutil attach "$TEMP_DIR/Bitwarden.dmg" -quiet
    
    # Find the actual volume name and app name
    BITWARDEN_VOLUME=$(ls /Volumes/ | grep -i bitwarden | head -1)
    BITWARDEN_APP=$(ls "/Volumes/$BITWARDEN_VOLUME/" | grep -E "\.app$" | head -1)
    
    if [ -n "$BITWARDEN_VOLUME" ] && [ -n "$BITWARDEN_APP" ]; then
        cp -R "/Volumes/$BITWARDEN_VOLUME/$BITWARDEN_APP" "/Applications/"
        hdiutil detach "/Volumes/$BITWARDEN_VOLUME" -quiet
        echo "Bitwarden installed successfully."
    else
        echo "Failed to locate Bitwarden app in mounted volume."
        hdiutil detach "/Volumes/$BITWARDEN_VOLUME" -quiet 2>/dev/null || true
    fi
else
    echo "Failed to download Bitwarden."
fi

# Clean up temporary directory
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Application installation completed."

# Download and install Brave
echo "Downloading Brave..."
curl -L -o "$TEMP_DIR/Brave.dmg" "https://laptop-updates.brave.com/latest/osx"

if [ $? -eq 0 ]; then
    echo "Installing Brave..."
    hdiutil attach "$TEMP_DIR/Brave.dmg" -quiet
    
    # Find the actual volume name and app name
    BRAVE_VOLUME=$(ls /Volumes/ | grep -i brave | head -1)
    BRAVE_APP=$(ls "/Volumes/$BRAVE_VOLUME/" | grep -E "\.app$" | head -1)
    
    if [ -n "$BRAVE_VOLUME" ] && [ -n "$BRAVE_APP" ]; then
        cp -R "/Volumes/$BRAVE_VOLUME/$BRAVE_APP" "/Applications/"
        hdiutil detach "/Volumes/$BRAVE_VOLUME" -quiet
        echo "Brave installed successfully."
    else
        echo "Failed to locate Brave app in mounted volume."
        hdiutil detach "/Volumes/$BRAVE_VOLUME" -quiet 2>/dev/null || true
    fi
else
    echo "Failed to download Brave."
fi

# Clean up temporary directory
echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Application installation completed."

###################################################
#                                                 #
#               System Cleanup                    #
#                                                 #
###################################################

# Empty Trash
rm -rf ~/.Trash/*