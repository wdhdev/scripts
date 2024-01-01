# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root or using sudo."
    exit 1
fi

# Update
echo "Updating system packages..."
apt update -y

# Upgrade
echo "Upgrading system packages..."
apt upgrade -y

# Install raspi-config
echo "Installing raspi-config..."
apt install raspi-config -y

# Prompt user for confirmation
read -p "Do you want to enable root SSH login? (y/n): " root_choice

if [[ $root_choice == "y" || $root_choice == "Y" ]]; then
    # Enable root login by modifying the sshd_config file
    sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

    # Restart the SSH service to apply changes
    echo "Restarting SSH service..."
    systemctl restart ssh

    echo "Root login enabled."
fi

# Complete
echo "Raspberry Pi initialisation complete."
