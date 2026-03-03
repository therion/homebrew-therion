# homebrew-therion

Therion is cave surveying software - for details see https://therion.speleo.sk

This repository hosts a Homebrew formula for easier installation and updates of Therion on macOS.

Please do not report issues unrelated to installing Therion on macOS here. Therion bugs and feature requests belong in: https://github.com/therion/therion.

## Installation

This formula uses CMake (not the legacy Make-based build). If you hit installation issues, please check [Troubleshooting](#troubleshooting) before submitting an issue.

Please launch Terminal app and follow the instructions.

### 1. Install Homebrew - https://brew.sh/

You need local admin rights to install Homebrew and the Xcode Command Line Tools. During the installation, macOS will prompt for your password (possibly more than once).

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Command Line Tools for Xcode will be downloaded and installed automatically.

After Homebrew finishes installing, follow any "Next steps" shown by the installer so PATH updates take effect.

If the `brew` command is still not found in your current Terminal session, either open a new Terminal window, or run:

Apple Silicon: `eval "$(/opt/homebrew/bin/brew shellenv)"`

Intel: `eval "$(/usr/local/bin/brew shellenv)"`

Test it:

`brew update`

`brew doctor`

If you want to disable Homebrew analytics, run:

`brew analytics off`

### 2. Install Prerequisites

- XQuartz provides the X11 server required by XTherion (X11 GUI).
- MacTeX provides TeX/LaTeX tools used by Therion to generate map outputs (e.g., PDF) and related typesetting.

`brew install --cask xquartz`

`brew install --cask basictex`

### 3. Install Therion

If you already have Therion installed from the previous tap (ladislavb/homebrew-therion), please run the following commands first:

`brew uninstall therion`

`brew untap ladislavb/homebrew-therion`

Tap a new repository and install the stable version of Therion from there:

`brew tap therion/homebrew-therion`

`brew install therion`

The formula is typically updated after each stable Therion release and/or when macOS changes. Pull requests with fixes are welcome.

If you want to test the latest (development) revision from Therion's source code on GitHub, run:

`brew install --HEAD therion`

### 4. Copying Loch to /Applications

Loch is installed inside the Therion Cellar prefix. If you have an older version of Loch in Applications, remove it, then copy the new version with:

`cp -R "$(brew --prefix therion)/loch.app" /Applications/loch.app`

## Running apps

Open a new Terminal window.

You should be able to:

- start XTherion by typing `xtherion` command to Terminal window
- run Therion compiler by typing `therion` command to Terminal window
- launch Loch viewer from Launchpad

## Upgrade

Launch Terminal app and type:

`brew update`

`brew upgrade therion`

If you copied Loch to /Applications before, copy it again after upgrade:

`cp -R "$(brew --prefix therion)/loch.app" /Applications/loch.app`

## Uninstall

Launch Terminal app and type:

`brew uninstall therion`

Optional cleanup:

`rm -rf /Applications/loch.app`

## Troubleshooting

### XTherion UI is broken

After starting XTherion from Terminal you see the following warning: `DEPRECATION WARNING: The system version of Tk is deprecated and may be removed in a future release. Please don't rely on it. Set TK_SILENCE_DEPRECATION=1 to suppress this warning.`

Solution/Workaround:

- Add homebrew Tcl/Tk version to the first place in $PATH variable: \
Apple Silicon: `echo 'export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"' >> ~/.zshrc` \
Intel: `echo 'export PATH="/usr/local/opt/tcl-tk/bin:$PATH"' >> ~/.zshrc`
- Open new Terminal window and run XTherion. It should use newer Tcl/Tk version from now on.
