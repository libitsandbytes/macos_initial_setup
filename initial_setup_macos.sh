#!/bin/bash

###################################################
#                                                 #
#             Config the script                   #
#                                                 #
###################################################

# Set to true to install the app, false to skip
bitwarden_install=true                  # Bitwarden is an open source, externally audited password manager
brave_install=true                      # Brave is a privacy friendly browser based on Chromium (compatible with Chrome extensions)
deepl_install=true                      # DeepL is a machine translation service
deno_install=true                       # Deno is a secure runtime for JavaScript and TypeScript
excalidrawz_install=true                # ExcalidrawZ is a native macOS client for Excalidraw, a virtual whiteboard
exiftool_install=true                   # ExifTool is a CLI tool for reading and writing metadata in media files
ffmpeg_install=true                     # FFmpeg is a multimedia framework for encoding, decoding, and converting audio/video
gimp_install=true                       # GIMP is an image editor, alternative to Adobe Photoshop
ghostscript_install=true                # Ghostscript is an interpreter for PostScript and PDF files
inkscape_install=true                   # Inkscape is a vector graphics editor, alternative to Adobe Illustrator
kdrive_install=true                     # kDrive is a cloud storage platform, alternative to Google Drive, Microsoft OneDrive, Dropbox
mactexnogui_install=true                # MacTeX (no GUI) is a TeX/LaTeX distribution for macOS without GUI applications
onlyoffice_install=true                 # OnlyOffice is an office suite that provides editors for documents, spreadsheets, presentations, and PDFs, alternative to Microsoft Office
opencode_install=true                   # OpenCode is a free and open-source artificial intelligence coding agent, alternative to Claude Code and Codex
pandoc_install=true                     # Pandoc is a document converter for converting between markup formats
pearcleaner_install=true                # PearCleaner is an app uninstaller for macOS
protonmail_install=true                 # Proton Mail is the desktop mail and calendar client for Proton services
rectangle_install=true                  # Rectangle is a window manager for moving and resizing windows with keyboard shortcuts
rustdesk_install=true                   # RustDesk is an open-source remote desktop client, alternative to TeamViewer
sherlock_install=true                   # Sherlock is a CLI tool for finding usernames across social media
signal_install=true                     # Signal Messenger is a privacy friendly alternative to messaging apps like WhatsApp
spotify_install=true                    # Spotify is a music streaming service
transmission_install=true               # Transmission is a BitTorrent client
upscayl_install=true                    # Upscayl is an AI image upscaler
vscodium_install=true                   # VSCodium is a VS Code distribution without Microsoft telemetry
ytdlp_install=true                      # yt-dlp is a free and open-source tool for downloading video and audio from YouTube and over 1,000 other video hosting websites


###################################################
#                                                 #
#               Global MacOS                      #
#                                                 #
###################################################

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

# Enable "Group windows by application" in Mission Control
defaults write com.apple.dock expose-group-apps -bool true

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
defaults write com.apple.screencapture "location" -string "~/Downloads"

# Set screenshots image format to jpg
defaults write com.apple.screencapture "type" -string "jpg"

# Restart SystemUIServer to load changes
killall SystemUIServer

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
defaults write com.apple.Finder ShowHardDrivesOnDesktop -bool false

# Hide external hard drives on desktop
defaults write com.apple.Finder ShowExternalHardDrivesOnDesktop -bool false

# Hide removable media on desktop
defaults write com.apple.Finder ShowRemovableMediaOnDesktop -bool false

# Hide mounted servers on desktop
defaults write com.apple.Finder ShowMountedServersOnDesktop -bool false

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
#           Other MacOS default apps              #
#                                                 #
###################################################

# Set nano as editor in the terminal
grep -q 'export EDITOR=nano' ~/.zshrc 2>/dev/null || echo 'export EDITOR=nano' >> ~/.zshrc
grep -q 'export VISUAL="$EDITOR"' ~/.zshrc 2>/dev/null || echo 'export VISUAL="$EDITOR"' >> ~/.zshrc

# Disable smart quotes in TextEdit
defaults write com.apple.TextEdit "SmartQuotes" -bool "false"

# Disable default rich text in TextEdit
defaults write com.apple.TextEdit "RichText" -bool "false"

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
if [ "$protonmail_install" = true ]; then
    echo "Downloading ProtonMail..."
    curl -fL -o "$TEMP_DIR/ProtonMail-desktop.dmg" "https://proton.me/download/mail/macos/ProtonMail-desktop.dmg"

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
else
    echo "Skipping Proton Mail installation (protonmail_install=false)."
fi


# Get latest Signal Messenger version and download URL
if [ "$signal_install" = true ]; then
    echo "Checking latest Signal Messenger version..."
    SIGNAL_LATEST=$(curl -fs "https://api.github.com/repos/signalapp/Signal-Desktop/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    SIGNAL_VERSION=$(echo $SIGNAL_LATEST | sed 's/^v//')
    SIGNAL_URL="https://updates.signal.org/desktop/signal-desktop-mac-universal-$SIGNAL_VERSION.dmg"

    echo "Downloading Signal Messenger..."

    curl -fL -o "$TEMP_DIR/Signal.dmg" "$SIGNAL_URL"

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
else
    echo "Skipping Signal Messenger installation (signal_install=false)."
fi


# Download and install Bitwarden
if [ "$bitwarden_install" = true ]; then
    echo "Downloading Bitwarden..."
    curl -fL -o "$TEMP_DIR/Bitwarden.dmg" "https://bitwarden.com/download/?app=desktop&platform=macos&variant=dmg"

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
else
    echo "Skipping Bitwarden installation (bitwarden_install=false)."
fi


# Download and install OpenCode
if [ "$opencode_install" = true ]; then
    echo "Downloading OpenCode..."
    curl -fL -o "$TEMP_DIR/OpenCode.dmg" "https://github.com/anomalyco/opencode/releases/latest/download/opencode-desktop-mac-arm64.dmg"

    if [ $? -eq 0 ]; then
        echo "Installing OpenCode..."
        hdiutil attach "$TEMP_DIR/OpenCode.dmg" -quiet

        # Find the actual volume name and app name
        OPENCODE_VOLUME=$(ls /Volumes/ | grep -i opencode | head -1)
        OPENCODE_APP=$(ls "/Volumes/$OPENCODE_VOLUME/" | grep -E "\.app$" | head -1)

        if [ -n "$OPENCODE_VOLUME" ] && [ -n "$OPENCODE_APP" ]; then
            cp -R "/Volumes/$OPENCODE_VOLUME/$OPENCODE_APP" "/Applications/"
            hdiutil detach "/Volumes/$OPENCODE_VOLUME" -quiet
            echo "OpenCode installed successfully."
        else
            echo "Failed to locate OpenCode app in mounted volume."
            hdiutil detach "/Volumes/$OPENCODE_VOLUME" -quiet 2>/dev/null || true
        fi
    else
        echo "Failed to download OpenCode."
    fi
else
    echo "Skipping OpenCode installation (opencode_install=false)."
fi


# Download and install ONLYOFFICE
if [ "$onlyoffice_install" = true ]; then
    echo "Downloading ONLYOFFICE..."
    curl -fL -o "$TEMP_DIR/ONLYOFFICE.dmg" "https://github.com/ONLYOFFICE/DesktopEditors/releases/latest/download/ONLYOFFICE-arm.dmg"

    if [ $? -eq 0 ]; then
        echo "Installing ONLYOFFICE..."
        hdiutil attach "$TEMP_DIR/ONLYOFFICE.dmg" -quiet

        # Find the actual volume name and app name
        ONLYOFFICE_VOLUME=$(ls /Volumes/ | grep -i onlyoffice | head -1)
        ONLYOFFICE_APP=$(ls "/Volumes/$ONLYOFFICE_VOLUME/" | grep -E "\.app$" | head -1)

        if [ -n "$ONLYOFFICE_VOLUME" ] && [ -n "$ONLYOFFICE_APP" ]; then
            cp -R "/Volumes/$ONLYOFFICE_VOLUME/$ONLYOFFICE_APP" "/Applications/"
            hdiutil detach "/Volumes/$ONLYOFFICE_VOLUME" -quiet
            echo "ONLYOFFICE installed successfully."
        else
            echo "Failed to locate ONLYOFFICE app in mounted volume."
            hdiutil detach "/Volumes/$ONLYOFFICE_VOLUME" -quiet 2>/dev/null || true
        fi
    else
        echo "Failed to download ONLYOFFICE."
    fi
else
    echo "Skipping OnlyOffice installation (onlyoffice_install=false)."
fi

# Download and install kDrive
if [ "$kdrive_install" = true ]; then
    echo "Installing kDrive..."

    echo "Fetching latest kDrive download URL..."
    KDRIVE_URL=$(curl -fsSL "https://www.infomaniak.com/drive/latest" \
        | grep -o '"macos":[^}]*' \
        | grep -o '"downloadurl": *"[^"]*"' \
        | sed 's/.*"downloadurl": *"//; s/"$//; s|\\/|/|g')

    if [ -n "$KDRIVE_URL" ]; then
        echo "Downloading kDrive from: $KDRIVE_URL"
        if curl -fL -o "$TEMP_DIR/kDrive.pkg" "$KDRIVE_URL"; then
            echo "Installing kDrive package..."
            if sudo installer -pkg "$TEMP_DIR/kDrive.pkg" -target /; then
                echo "kDrive installed successfully."
            else
                echo "Failed to install kDrive package."
            fi
        else
            echo "Failed to download kDrive."
        fi
    else
        echo "Failed to fetch kDrive download URL."
    fi
else
    echo "Skipping kDrive installation (kdrive_install=false)."
fi


# Download and install Brave
if [ "$brave_install" = true ]; then
    echo "Downloading Brave..."
    curl -fL -o "$TEMP_DIR/Brave.dmg" "https://laptop-updates.brave.com/latest/osx"

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

    ###################################################
    #                                                 #
    #                  Brave config                   #
    #                                                 #
    ###################################################

    # Configure Brave Browser
    echo "Configuring Brave Browser..."

    # Managed Settings - Security and Privacy Focused
    echo "Applying managed Brave settings..."
    defaults write com.brave.Browser TorDisabled -bool true
    defaults write com.brave.Browser BraveRewardsDisabled -bool true
    defaults write com.brave.Browser BraveWalletDisabled -bool true
    defaults write com.brave.Browser BraveVPNDisabled -bool true
    defaults write com.brave.Browser BraveAIChatEnabled -bool false
    defaults write com.brave.Browser ExtensionInstallForcelist -array "nngceckbapebfimnlniiiahkandclblb;https://clients2.google.com/service/update2/crx" "cofdbpoegempjloogbagkncekinflcnj;https://clients2.google.com/service/update2/crx"
    defaults write com.brave.Browser DefaultSearchProviderEnabled -bool true
    defaults write com.brave.Browser DefaultSearchProviderName -string "Startpage"
    defaults write com.brave.Browser DefaultSearchProviderSearchURL -string "https://eu.startpage.com/sp/search?query={searchTerms}&prfe=499dee7473ba6fe94b74ac8b94ee04457fc16b5d14c7e0db606858927c6bc283f953ad551f7beca19e503d14176eaa4d82029c8cace3cda754570c7e28fb666ab150c00038e7bbc587b259f03d61ba0edaae"
    defaults write com.brave.Browser AutofillAddressEnabled -bool false
    defaults write com.brave.Browser AutofillCreditCardEnabled -bool false
    defaults write com.brave.Browser PasswordManagerEnabled -bool false
    defaults write com.brave.Browser TranslateEnabled -bool false
    defaults write com.brave.Browser ImportAutofillFormData -bool false
    defaults write com.brave.Browser ImportSavedPasswords -bool false
    defaults write com.brave.Browser EnableMediaRouter -bool false

    # Recommended Settings - Enhanced Security and Usability
    echo "Applying recommended Brave settings..."
    defaults write com.brave.Browser AlwaysOpenPdfExternally -bool true
    defaults write com.brave.Browser BlockThirdPartyCookies -bool true
    defaults write com.brave.Browser BookmarkBarEnabled -bool true
    defaults write com.brave.Browser DefaultBrowserSettingEnabled -bool true
    defaults write com.brave.Browser DefaultGeolocationSetting -integer 2
    defaults write com.brave.Browser DefaultNotificationsSetting -integer 2
    defaults write com.brave.Browser DefaultSensorsSetting -integer 2
    defaults write com.brave.Browser HttpsUpgradesEnabled -bool true
    defaults write com.brave.Browser ClearBrowsingDataOnExitList -array "cookies_and_other_site_data" "cached_images_and_files" "password_signin" "autofill"

    echo "Brave Browser configuration completed."
else
    echo "Skipping Brave installation (brave_install=false)."
fi

###################################################
#                                                 #
#             Clean up install files              #
#                                                 #
###################################################

echo "Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "Application installation completed."

###################################################
#                                                 #
#              Homebrew & Packages                #
#                                                 #
###################################################

echo "Installing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for this session (Apple Silicon default location)
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Helper: install a brew formula/cask only if its toggle is true
brew_install() {
    local enabled="$1"
    shift
    if [ "$enabled" = true ]; then
        echo "Installing: brew install $*"
        brew install "$@"
    else
        echo "Skipping: brew install $* (toggle off)"
    fi
}

echo "Installing Homebrew packages..."

# Formulae
brew_install "$deno_install"           deno
brew_install "$exiftool_install"       exiftool
brew_install "$ffmpeg_install"         ffmpeg
brew_install "$ghostscript_install"    ghostscript
brew_install "$pandoc_install"         pandoc
brew_install "$sherlock_install"       sherlock
brew_install "$ytdlp_install"          yt-dlp

# Casks
brew_install "$deepl_install"         --cask deepl
brew_install "$excalidrawz_install"    --cask excalidrawz
brew_install "$gimp_install"           --cask gimp
brew_install "$inkscape_install"       --cask inkscape
brew_install "$mactexnogui_install"   --cask mactex-no-gui
brew_install "$pearcleaner_install"    --cask pearcleaner
brew_install "$rectangle_install"      --cask rectangle
brew_install "$rustdesk_install"       --cask rustdesk
brew_install "$spotify_install"        --cask spotify
brew_install "$transmission_install"   --cask transmission
brew_install "$upscayl_install"        --cask upscayl
brew_install "$vscodium_install"       --cask vscodium

echo "Homebrew package installation completed."

###################################################
#                                                 #
#                   Cron Jobs                     #
#                                                 #
###################################################

echo "Configuring cron jobs..."

# Add a cron entry only if it isn't already present (idempotent — safe to re-run)
add_cron() {
    local entry="$1"
    if ! crontab -l 2>/dev/null | grep -Fq -- "$entry"; then
        (crontab -l 2>/dev/null; echo "$entry") | crontab -
        echo "  + $entry"
    else
        echo "  = (already present) $entry"
    fi
}

# Weekly Homebrew update/cleanup — Sunday 23:00
add_cron '0 23 * * 0 /opt/homebrew/bin/brew update && /opt/homebrew/bin/brew upgrade && /opt/homebrew/bin/brew cleanup'

# Remove .DS_Store files every 5 min — $HOME resolves to whoever runs the script
for dir in kDrive Downloads Documents Movies Public Desktop Pictures Music; do
    add_cron "*/5 * * * * find $HOME/$dir -name '.DS_Store' -type f -delete >/dev/null 2>&1"
done

echo "Cron jobs configured."

###################################################
#                                                 #
#               System Cleanup                    #
#                                                 #
###################################################

# Empty Trash
rm -rf ~/.Trash/*
