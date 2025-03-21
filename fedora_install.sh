#!/bin/bash

# REQUEST SUDO PASSWORD BEFORE EXECUTING THE COMMAND
if sudo -v; then
    	echo "Updating the system..."
    	sudo dnf check-upgrade -y
    	echo "Update completed!"
fi

# ENABLE THE RPM FUSION REPOSITORIES
	read -p "Do you want to enable the RPM Fusion repositories? (y/n): " response_fusion
	if [[ "$response_fusion" =~ ^[Yy]$ ]]; then
		echo "Adding RPM Fusion repositories... "
		sudo dnf install -y \ 
        	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \ 
        	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
        	echo "Install appstrem metadata... "
        	sudo dnf group upgrade core -y
        	sudo dfn4 group update core -y
        	echo "RPM Fusion installed successfully! "
	else
		echo "RPM Fusion was not enabled. "
	fi

# INSTALL DNF PLUGINS
	read -p "Do you want to install dnf-plugins? (y/n): " response_plugins
	if [[ "$response_plugins" =~ ^[Yy]$ ]]; then
		echo "Install DNF plugins... "
		sudo dnf install -y dnf-plugins-core
		echo "DNF plugins installed successfuly! "
	else
		echo "DNF plugins was not installed! "
	fi

# INSTALL PACKAGES USER
	read -p "Do you install packages user? (y/n): " response_packages
	if [[ "$response_packages" =~ ^[Yy]$ ]]; then
    		echo "Installing Packages..."
    		sudo dnf install -y firefox thunderbird inkscape gimp vlc transmission gparted deja-dup bottles cmatrix cava fish dconf-editor 
    		echo "Packages installed successfully! "
	else
    		echo "Packages was not installed. "
    	fi

# INSTALL MEDIA CODECS
	read -p "Do you install media codecs? (y/n): " response_codecs
	if [[ "$response_codecs" =~ ^[Yy]$ ]]; then
		sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing
		sudo dnf4 group upgrade multimedia
		sudo dnf upgrade @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
		sudo dnf group install -y sound-and-video
		echo "Media codecs installed successfuly! "
	else
		echo "Media codecs was not installed! "
	fi

# INSTALL BRAVE BROWSER
	read -p "Do you enable repositories and install Brave Browser? (y/n): " response_brave
	if [[ "$response_brave" =~ ^[Yy]$ ]]; then
		echo "Adding Brave Browser repositories... "
		sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
		sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
		echo "Installing Brave Browser... "
		sudo dnf check-upgrade && sudo dnf install -y brave-browser
		echo "Brave Browser installed successfuly! "
	else
		echo "Brave Browser was not installed. "
	fi

# INSTALL VISUAL STUDIO CODE
	read -p "D you enable repositories and install Visual Studio Code? (y/n): " response_code
	if [[ "$response_code" =~ ^[Yy]$ ]]; then
		echo "Adding Visual Studio Code repositories... "
		sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
		echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
		echo "Installing Visual Studio Code... "
		sudo dnf check-upgrade && sudo dnf install -y code
		echo "Visual Studio Code installed successfuly! "
	else
		echo "Visual Studio Code was not installed. "
	fi

# INSTALL H/W VIDEO ACCELERATION
	read -p "Do you install H/W video acceleration? (y/n): " response_hw
	if [[ "$response_hw" =~ ^[Yy]$ ]]; then
		echo "Installing H/W video acceleration... "
		sudo dnf install -y ffmpeg-libs libva libva-utils
		echo "H/W video acceleration installed successfuly! "
	else
		echo "H/W video acceleration was not installed. "
	fi

# INSTALL INTEL DRIVER
	read -p "Do you install Intel driver? (y/n): " response_intel
	if [[ "$response_intel" =~ ^[Yy]$ ]]; then
		echo "Installing Intel driver... "
		sudo dnf swap libva-intel-media-driver intel-media-driver --allowerasing
		sudo dnf install -y libva-intel-driver
		echo "Intel driver installed successfuly! "
	else
		echo "Intel driver was not installed. "
	fi

# ENABLE FLATHUB REPOSITORY  
	read -p "Do you want to enable the Flathub repository? (y/n): " response_flathub
	if [[ "$response_flathub" =~ ^[Yy]$ ]]; then
        	echo "Enabling the Flathub repository... "
        	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        	echo "Flathub enabled successfully! "
        fi

# INSTALL FLATHUB APPS
	read -p "Do you want install Flatpak apps? (y/n): " response_flatpaks
	if [[ "$response_flatpaks" =~ ^[Yy]$ ]]; then
    		echo "Installing Flatpaks... "
    		flatpak install -y refine extensionmanager
    		echo "Flatpak installed successfuly! "
	else
        	echo "Flathub was not enabled. "
	fi

else
	echo "Sudo authentication failed. Exiting... "
	exit 1
fi

