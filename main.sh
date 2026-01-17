#!/bin/bash
clear

# =============================
# Modern Color Scheme & Styling
# =============================
# Reset
RESET='\033[0m'

# Regular Colors
BLACK='\033[0;30m'  RED='\033[0;31m'    GREEN='\033[0;32m'
YELLOW='\033[0;33m' BLUE='\033[0;34m'   PURPLE='\033[0;35m'
CYAN='\033[0;36m'   WHITE='\033[0;37m'

# Bold
B_BLACK='\033[1;30m' B_RED='\033[1;31m'   B_GREEN='\033[1;32m'
B_YELLOW='\033[1;33m' B_BLUE='\033[1;34m'  B_PURPLE='\033[1;35m'
B_CYAN='\033[1;36m'  B_WHITE='\033[1;37m'

# Backgrounds
BG_BLACK='\033[40m'  BG_RED='\033[41m'    BG_GREEN='\033[42m'
BG_YELLOW='\033[43m' BG_BLUE='\033[44m'   BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'   BG_WHITE='\033[47m'

# Icons
ICON_ROCKET="🚀"
ICON_BOX="📦"
ICON_GEAR="⚙️"
ICON_CHECK="✅"
ICON_ERROR="❌"
ICON_WARN="⚠️"
ICON_INFO="ℹ️"
ICON_TELE="📡"
ICON_RDP="🖥️"
ICON_VM="💾"

draw_banner() {
    echo -e "${B_CYAN}"
    cat << "EOF"
██╗░░██╗███████╗███╗░░██╗██████╗░██████╗░██╗░█████╗░██╗░░██╗
██║░██╔╝██╔════╝████╗░██║██╔══██╗██╔══██╗██║██╔══██╗██║░██╔╝
█████═╝░█████╗░░██╔██╗██║██║░░██║██████╔╝██║██║░░╚═╝█████═╝░
██╔═██╗░██╔══╝░░██║╚████║██║░░██║██╔══██╗██║██║░░██╗██╔═██╗░
██║░╚██╗███████╗██║░╚███║██████╔╝██║░░██║██║╚█████╔╝██║░╚██╗
╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░╚════╝░╚═╝░░╚═╝
EOF
    echo -e "${RESET}"
    echo -e "${B_PURPLE}   >>>  Ultimate All In One Tool  <<<   ${RESET}"
    echo -e "${B_BLUE}   ---------------------------------------------   ${RESET}"
    echo
}

# Function to display sub-menu header
display_submenu_header() {
    clear
    echo -e "${B_CYAN}"
    cat << "EOF"
    
  _  ________ _   _ _____  _____  _____ _____ _  __
 | |/ /  ____| \ | |  __ \|  __ \|_   _/ ____| |/ /
 | ' /| |__  |  \| | |  | | |__) | | || |    | ' / 
 |  < |  __| | . ` | |  | |  _  /  | || |    |  <  
 | . \| |____| |\  | |__| | | \ \ _| || |____| . \ 
 |_|\_\______|_| \_|_____/|_|  \_\_____\_____|_|\_\
                                                   
EOF
    echo -e "${RESET}"
    echo -e "${B_PURPLE}   >>>  Ultimate All In One Tool  <<<   ${RESET}"
    echo -e "${B_BLUE}   ---------------------------------------------   ${RESET}"
    echo
}

# VPS Menu

# Function to generate vm.sh script
generate_vm_script() {
    cat <<'EOF_VM_CONTENT'
#!/bin/bash
set -euo pipefail

# === Full VM Manager Script ===
#!/bin/bash
set -euo pipefail

# =============================
# Enhanced Multi-VM Manager
# =============================

# Colors & Icons
RESET='\033[0m'
BLACK='\033[0;30m'  RED='\033[0;31m'    GREEN='\033[0;32m'
YELLOW='\033[0;33m' BLUE='\033[0;34m'   PURPLE='\033[0;35m'
CYAN='\033[0;36m'   WHITE='\033[0;37m'

B_BLACK='\033[1;30m' B_RED='\033[1;31m'   B_GREEN='\033[1;32m'
B_YELLOW='\033[1;33m' B_BLUE='\033[1;34m'  B_PURPLE='\033[1;35m'
B_CYAN='\033[1;36m'  B_WHITE='\033[1;37m'

# Backgrounds
BG_BLACK='\033[40m'  BG_RED='\033[41m'    BG_GREEN='\033[42m'
BG_YELLOW='\033[43m' BG_BLUE='\033[44m'   BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'   BG_WHITE='\033[47m'

ICON_VM="💾"
ICON_ROCKET="🚀"
ICON_BOX="📦"
ICON_GEAR="⚙️"
ICON_CHECK="✅"
ICON_ERROR="❌"
ICON_WARN="⚠️"
ICON_INFO="ℹ️"
ICON_TELE="📡"
ICON_RDP="🖥️"


# Function to display header
display_header() {
    clear
    echo -e "${B_CYAN}"
    cat << "EOF"
    
 ██╗░░██╗███████╗███╗░░██╗██████╗░██████╗░██╗░█████╗░██╗░░██╗
 ██║░██╔╝██╔════╝████╗░██║██╔══██╗██╔══██╗██║██╔══██╗██║░██╔╝
 █████═╝░█████╗░░██╔██╗██║██║░░██║██████╔╝██║██║░░╚═╝█████═╝░
 ██╔═██╗░██╔══╝░░██║╚████║██║░░██║██╔══██╗██║██║░░██╗██╔═██╗░
 ██║░╚██╗███████╗██║░╚███║██████╔╝██║░░██║██║╚█████╔╝██║░╚██╗
 ╚═╝░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░╚════╝░╚═╝░░╚═╝
EOF
    echo -e "${RESET}"
    echo -e "${B_YELLOW}             >>>  Ultimate VM Manager Tool  <<<   ${RESET}"
    echo -e "${B_BLUE}             ---------------------------------------------   ${RESET}"
    echo -e "                 ${B_PURPLE}Original VM Manager Script By Hopingboyz , Modified By Kendrick${RESET}"
    echo
}

# Function to display colored output
print_status() {
    local type=$1
    local message=$2
    
    case $type in
        "INFO") echo -e "\033[1;34m[ℹ️ INFO]\033[0m  $message" ;;
        "WARN") echo -e "\033[1;33m[⚠️ WARN]\033[0m  $message" ;;
        "ERROR") echo -e "\033[1;31m[❌ ERROR]\033[0m $message" ;;
        "SUCCESS") echo -e "\033[1;32m[✅ OK]\033[0m    $message" ;;
        "INPUT") echo -e "\033[1;36m[👉 INPUT]\033[0m $message" ;;
        *) echo "[$type] $message" ;;
    esac
}

# Function to validate input
validate_input() {
    local type=$1
    local value=$2
    
    case $type in
        "number")
            if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                print_status "ERROR" "Must be a number"
                return 1
            fi
            ;;
        "size")
            if ! [[ "$value" =~ ^[0-9]+[GgMm]$ ]]; then
                print_status "ERROR" "Must be a size with unit (e.g., 100G, 512M)"
                return 1
            fi
            ;;
        "port")
            if ! [[ "$value" =~ ^[0-9]+$ ]] || [ "$value" -lt 23 ] || [ "$value" -gt 65535 ]; then
                print_status "ERROR" "Must be a valid port number (23-65535)"
                return 1
            fi
            ;;
        "name")
            if ! [[ "$value" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                print_status "ERROR" "VM name can only contain letters, numbers, hyphens, and underscores"
                return 1
            fi
            ;;
        "username")
            if ! [[ "$value" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
                print_status "ERROR" "Username must start with a letter or underscore, and contain only letters, numbers, hyphens, and underscores"
                return 1
            fi
            ;;
    esac
    return 0
}

# Function to check dependencies
check_dependencies() {
    local deps=("qemu-system-x86_64" "wget" "cloud-localds" "qemu-img")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_status "ERROR" "Missing dependencies: ${missing_deps[*]}"
        print_status "INFO" "On Ubuntu/Debian, try: sudo apt install qemu-system cloud-image-utils wget"
        exit 1
    fi
}

# Function to cleanup temporary files
cleanup() {
    if [ -f "user-data" ]; then rm -f "user-data"; fi
    if [ -f "meta-data" ]; then rm -f "meta-data"; fi
}

# Function to get all VM configurations
get_vm_list() {
    find "$VM_DIR" -name "*.conf" -exec basename {} .conf \; 2>/dev/null | sort
}

# Function to load VM configuration
load_vm_config() {
    local vm_name=$1
    local config_file="$VM_DIR/$vm_name.conf"
    
    if [[ -f "$config_file" ]]; then
        # Clear previous variables
        unset VM_NAME OS_TYPE CODENAME IMG_URL HOSTNAME USERNAME PASSWORD
        unset DISK_SIZE MEMORY CPUS SSH_PORT GUI_MODE PORT_FORWARDS IMG_FILE SEED_FILE CREATED
        
        source "$config_file"
        return 0
    else
        print_status "ERROR" "Configuration for VM '$vm_name' not found"
        return 1
    fi
}

# Function to save VM configuration
save_vm_config() {
    local config_file="$VM_DIR/$VM_NAME.conf"
    
    cat > "$config_file" <<EOF
VM_NAME="$VM_NAME"
OS_TYPE="$OS_TYPE"
CODENAME="$CODENAME"
IMG_URL="$IMG_URL"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
PASSWORD="$PASSWORD"
DISK_SIZE="$DISK_SIZE"
MEMORY="$MEMORY"
CPUS="$CPUS"
SSH_PORT="$SSH_PORT"
GUI_MODE="$GUI_MODE"
PORT_FORWARDS="$PORT_FORWARDS"
IMG_FILE="$IMG_FILE"
SEED_FILE="$SEED_FILE"
CREATED="$CREATED"
EOF
    
    print_status "SUCCESS" "Configuration saved to $config_file"
}

# Function to create new VM
create_new_vm() {
    print_status "INFO" "Creating a new VM"
    
    # OS Selection
    print_status "INFO" "Select an OS to set up:"
    local os_options=()
    local i=1
    for os in "${!OS_OPTIONS[@]}"; do
        echo "  $i) $os"
        os_options[$i]="$os"
        ((i++))
    done
    
    while true; do
        read -p "$(print_status "INPUT" "Enter your choice (1-${#OS_OPTIONS[@]}): ")" choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#OS_OPTIONS[@]} ]; then
            local os="${os_options[$choice]}"
            IFS='|' read -r OS_TYPE CODENAME IMG_URL DEFAULT_HOSTNAME DEFAULT_USERNAME DEFAULT_PASSWORD <<< "${OS_OPTIONS[$os]}"
            break
        else
            print_status "ERROR" "Invalid selection. Try again."
        fi
    done

    # Custom Inputs with validation
    while true; do
        read -p "$(print_status "INPUT" "Enter VM name (default: $DEFAULT_HOSTNAME): ")" VM_NAME
        VM_NAME="${VM_NAME:-$DEFAULT_HOSTNAME}"
        if validate_input "name" "$VM_NAME"; then
            # Check if VM name already exists
            if [[ -f "$VM_DIR/$VM_NAME.conf" ]]; then
                print_status "ERROR" "VM with name '$VM_NAME' already exists"
            else
                break
            fi
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Enter hostname (default: $VM_NAME): ")" HOSTNAME
        HOSTNAME="${HOSTNAME:-$VM_NAME}"
        if validate_input "name" "$HOSTNAME"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Enter username (default: $DEFAULT_USERNAME): ")" USERNAME
        USERNAME="${USERNAME:-$DEFAULT_USERNAME}"
        if validate_input "username" "$USERNAME"; then
            break
        fi
    done

    while true; do
        read -s -p "$(print_status "INPUT" "Enter password (default: $DEFAULT_PASSWORD): ")" PASSWORD
        PASSWORD="${PASSWORD:-$DEFAULT_PASSWORD}"
        echo
        if [ -n "$PASSWORD" ]; then
            break
        else
            print_status "ERROR" "Password cannot be empty"
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Disk size (default: 20G): ")" DISK_SIZE
        DISK_SIZE="${DISK_SIZE:-20G}"
        if validate_input "size" "$DISK_SIZE"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Memory in MB (default: 2048): ")" MEMORY
        MEMORY="${MEMORY:-2048}"
        if validate_input "number" "$MEMORY"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Number of CPUs (default: 2): ")" CPUS
        CPUS="${CPUS:-2}"
        if validate_input "number" "$CPUS"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "SSH Port (default: 2222): ")" SSH_PORT
        SSH_PORT="${SSH_PORT:-2222}"
        if validate_input "port" "$SSH_PORT"; then
            # Check if port is already in use
            if ss -tln 2>/dev/null | grep -q ":$SSH_PORT "; then
                print_status "ERROR" "Port $SSH_PORT is already in use"
            else
                break
            fi
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "Enable GUI mode? (y/n, default: n): ")" gui_input
        GUI_MODE=false
        gui_input="${gui_input:-n}"
        if [[ "$gui_input" =~ ^[Yy]$ ]]; then 
            GUI_MODE=true
            break
        elif [[ "$gui_input" =~ ^[Nn]$ ]]; then
            break
        else
            print_status "ERROR" "Please answer y or n"
        fi
    done

    # Additional network options
    read -p "$(print_status "INPUT" "Additional port forwards (e.g., 8080:80, press Enter for none): ")" PORT_FORWARDS

    IMG_FILE="$VM_DIR/$VM_NAME.img"
    SEED_FILE="$VM_DIR/$VM_NAME-seed.iso"
    CREATED="$(date)"

    # Download and setup VM image
    setup_vm_image
    
    # Save configuration
    save_vm_config
}

# Function to setup VM image
setup_vm_image() {
    print_status "INFO" "Downloading and preparing image..."
    
    # Create VM directory if it doesn't exist
    mkdir -p "$VM_DIR"
    
    # Check if image already exists
    if [[ -f "$IMG_FILE" ]]; then
        print_status "INFO" "Image file already exists. Skipping download."
    else
        print_status "INFO" "Downloading image from $IMG_URL..."
        if ! wget --progress=bar:force "$IMG_URL" -O "$IMG_FILE.tmp"; then
            print_status "ERROR" "Failed to download image from $IMG_URL"
            exit 1
        fi
        mv "$IMG_FILE.tmp" "$IMG_FILE"
    fi
    
    # Resize the disk image if needed
    if ! qemu-img resize "$IMG_FILE" "$DISK_SIZE" 2>/dev/null; then
        print_status "WARN" "Failed to resize disk image. Creating new image with specified size..."
        # Create a new image with the specified size
        rm -f "$IMG_FILE"
        qemu-img create -f qcow2 -F qcow2 -b "$IMG_FILE" "$IMG_FILE.tmp" "$DISK_SIZE" 2>/dev/null || \
        qemu-img create -f qcow2 "$IMG_FILE" "$DISK_SIZE"
        if [ -f "$IMG_FILE.tmp" ]; then
            mv "$IMG_FILE.tmp" "$IMG_FILE"
        fi
    fi

    # cloud-init configuration
    cat > user-data <<EOF
#cloud-config
hostname: $HOSTNAME
ssh_pwauth: true
disable_root: false
users:
  - name: $USERNAME
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    password: $(openssl passwd -6 "$PASSWORD" | tr -d '\n')
chpasswd:
  list: |
    root:$PASSWORD
    $USERNAME:$PASSWORD
  expire: false
EOF

    cat > meta-data <<EOF
instance-id: iid-$VM_NAME
local-hostname: $HOSTNAME
EOF

    if ! cloud-localds "$SEED_FILE" user-data meta-data; then
        print_status "ERROR" "Failed to create cloud-init seed image"
        exit 1
    fi
    
    print_status "SUCCESS" "VM '$VM_NAME' created successfully."
}

# Function to start a VM
start_vm() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        print_status "INFO" "Starting VM: $vm_name"
        print_status "INFO" "SSH: ssh -p $SSH_PORT $USERNAME@localhost"
        print_status "INFO" "Password: $PASSWORD"
        
        # Check if image file exists
        if [[ ! -f "$IMG_FILE" ]]; then
            print_status "ERROR" "VM image file not found: $IMG_FILE"
            return 1
        fi
        
        # Check if seed file exists
        if [[ ! -f "$SEED_FILE" ]]; then
            print_status "WARN" "Seed file not found, recreating..."
            setup_vm_image
        fi
        
        # Base QEMU command
        local qemu_cmd=(
            qemu-system-x86_64
            -enable-kvm
            -m "$MEMORY"
            -smp "$CPUS"
            -cpu host
            -drive "file=$IMG_FILE,format=qcow2,if=virtio"
            -drive "file=$SEED_FILE,format=raw,if=virtio"
            -boot order=c
            -device virtio-net-pci,netdev=n0
            -netdev "user,id=n0,hostfwd=tcp::$SSH_PORT-:22"
        )

        # Add port forwards if specified
        if [[ -n "$PORT_FORWARDS" ]]; then
            IFS=',' read -ra forwards <<< "$PORT_FORWARDS"
            for forward in "${forwards[@]}"; do
                IFS=':' read -r host_port guest_port <<< "$forward"
                qemu_cmd+=(-device "virtio-net-pci,netdev=n${#qemu_cmd[@]}")
                qemu_cmd+=(-netdev "user,id=n${#qemu_cmd[@]},hostfwd=tcp::$host_port-:$guest_port")
            done
        fi

        # Add GUI or console mode
        if [[ "$GUI_MODE" == true ]]; then
            qemu_cmd+=(-vga virtio -display gtk,gl=off)
        else
            qemu_cmd+=(-nographic -serial mon:stdio)
        fi

        # Add performance enhancements
        qemu_cmd+=(
            -device virtio-balloon-pci
            -object rng-random,filename=/dev/urandom,id=rng0
            -device virtio-rng-pci,rng=rng0
        )

        print_status "INFO" "Starting QEMU..."
        "${qemu_cmd[@]}"
        
        print_status "INFO" "VM $vm_name has been shut down"
    fi
}

# Function to delete a VM
delete_vm() {
    local vm_name=$1
    
    print_status "WARN" "This will permanently delete VM '$vm_name' and all its data!"
    read -p "$(print_status "INPUT" "Are you sure? (y/N): ")" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if load_vm_config "$vm_name"; then
            rm -f "$IMG_FILE" "$SEED_FILE" "$VM_DIR/$vm_name.conf"
            print_status "SUCCESS" "VM '$vm_name' has been deleted"
        fi
    else
        print_status "INFO" "Deletion cancelled"
    fi
}

# Function to show VM info
show_vm_info() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        echo
        print_status "INFO" "VM Information: $vm_name"
        echo "=========================================="
        echo "OS: $OS_TYPE"
        echo "Hostname: $HOSTNAME"
        echo "Username: $USERNAME"
        echo "Password: $PASSWORD"
        echo "SSH Port: $SSH_PORT"
        echo "Memory: $MEMORY MB"
        echo "CPUs: $CPUS"
        echo "Disk: $DISK_SIZE"
        echo "GUI Mode: $GUI_MODE"
        echo "Port Forwards: ${PORT_FORWARDS:-None}"
        echo "Created: $CREATED"
        echo "Image File: $IMG_FILE"
        echo "Seed File: $SEED_FILE"
        echo "=========================================="
        echo
        read -p "$(print_status "INPUT" "Press Enter to continue...")"
    fi
}

# Function to check if VM is running
is_vm_running() {
    local vm_name=$1
    if pgrep -f "qemu-system-x86_64.*$vm_name" >/dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to stop a running VM
stop_vm() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        if is_vm_running "$vm_name"; then
            print_status "INFO" "Stopping VM: $vm_name"
            pkill -f "qemu-system-x86_64.*$IMG_FILE"
            sleep 2
            if is_vm_running "$vm_name"; then
                print_status "WARN" "VM did not stop gracefully, forcing termination..."
                pkill -9 -f "qemu-system-x86_64.*$IMG_FILE"
            fi
            print_status "SUCCESS" "VM $vm_name stopped"
        else
            print_status "INFO" "VM $vm_name is not running"
        fi
    fi
}

# Function to edit VM configuration
edit_vm_config() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        print_status "INFO" "Editing VM: $vm_name"
        
        while true; do
            echo "What would you like to edit?"
            echo "  1) Hostname"
            echo "  2) Username"
            echo "  3) Password"
            echo "  4) SSH Port"
            echo "  5) GUI Mode"
            echo "  6) Port Forwards"
            echo "  7) Memory (RAM)"
            echo "  8) CPU Count"
            echo "  9) Disk Size"
            echo "  0) Back to main menu"
            
            read -p "$(print_status "INPUT" "Enter your choice: ")" edit_choice
            
            case $edit_choice in
                1)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new hostname (current: $HOSTNAME): ")" new_hostname
                        new_hostname="${new_hostname:-$HOSTNAME}"
                        if validate_input "name" "$new_hostname"; then
                            HOSTNAME="$new_hostname"
                            break
                        fi
                    done
                    ;;
                2)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new username (current: $USERNAME): ")" new_username
                        new_username="${new_username:-$USERNAME}"
                        if validate_input "username" "$new_username"; then
                            USERNAME="$new_username"
                            break
                        fi
                    done
                    ;;
                3)
                    while true; do
                        read -s -p "$(print_status "INPUT" "Enter new password (current: ****): ")" new_password
                        new_password="${new_password:-$PASSWORD}"
                        echo
                        if [ -n "$new_password" ]; then
                            PASSWORD="$new_password"
                            break
                        else
                            print_status "ERROR" "Password cannot be empty"
                        fi
                    done
                    ;;
                4)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new SSH port (current: $SSH_PORT): ")" new_ssh_port
                        new_ssh_port="${new_ssh_port:-$SSH_PORT}"
                        if validate_input "port" "$new_ssh_port"; then
                            # Check if port is already in use
                            if [ "$new_ssh_port" != "$SSH_PORT" ] && ss -tln 2>/dev/null | grep -q ":$new_ssh_port "; then
                                print_status "ERROR" "Port $new_ssh_port is already in use"
                            else
                                SSH_PORT="$new_ssh_port"
                                break
                            fi
                        fi
                    done
                    ;;
                5)
                    while true; do
                        read -p "$(print_status "INPUT" "Enable GUI mode? (y/n, current: $GUI_MODE): ")" gui_input
                        gui_input="${gui_input:-}"
                        if [[ "$gui_input" =~ ^[Yy]$ ]]; then 
                            GUI_MODE=true
                            break
                        elif [[ "$gui_input" =~ ^[Nn]$ ]]; then
                            GUI_MODE=false
                            break
                        elif [ -z "$gui_input" ]; then
                            # Keep current value if user just pressed Enter
                            break
                        else
                            print_status "ERROR" "Please answer y or n"
                        fi
                    done
                    ;;
                6)
                    read -p "$(print_status "INPUT" "Additional port forwards (current: ${PORT_FORWARDS:-None}): ")" new_port_forwards
                    PORT_FORWARDS="${new_port_forwards:-$PORT_FORWARDS}"
                    ;;
                7)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new memory in MB (current: $MEMORY): ")" new_memory
                        new_memory="${new_memory:-$MEMORY}"
                        if validate_input "number" "$new_memory"; then
                            MEMORY="$new_memory"
                            break
                        fi
                    done
                    ;;
                8)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new CPU count (current: $CPUS): ")" new_cpus
                        new_cpus="${new_cpus:-$CPUS}"
                        if validate_input "number" "$new_cpus"; then
                            CPUS="$new_cpus"
                            break
                        fi
                    done
                    ;;
                9)
                    while true; do
                        read -p "$(print_status "INPUT" "Enter new disk size (current: $DISK_SIZE): ")" new_disk_size
                        new_disk_size="${new_disk_size:-$DISK_SIZE}"
                        if validate_input "size" "$new_disk_size"; then
                            DISK_SIZE="$new_disk_size"
                            break
                        fi
                    done
                    ;;
                0)
                    return 0
                    ;;
                *)
                    print_status "ERROR" "Invalid selection"
                    continue
                    ;;
            esac
            
            # Recreate seed image with new configuration if user/password/hostname changed
            if [[ "$edit_choice" -eq 1 || "$edit_choice" -eq 2 || "$edit_choice" -eq 3 ]]; then
                print_status "INFO" "Updating cloud-init configuration..."
                setup_vm_image
            fi
            
            # Save configuration
            save_vm_config
            
            read -p "$(print_status "INPUT" "Continue editing? (y/N): ")" continue_editing
            if [[ ! "$continue_editing" =~ ^[Yy]$ ]]; then
                break
            fi
        done
    fi
}

# Function to resize VM disk
resize_vm_disk() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        print_status "INFO" "Current disk size: $DISK_SIZE"
        
        while true; do
            read -p "$(print_status "INPUT" "Enter new disk size (e.g., 50G): ")" new_disk_size
            if validate_input "size" "$new_disk_size"; then
                if [[ "$new_disk_size" == "$DISK_SIZE" ]]; then
                    print_status "INFO" "New disk size is the same as current size. No changes made."
                    return 0
                fi
                
                # Check if new size is smaller than current (not recommended)
                local current_size_num=${DISK_SIZE%[GgMm]}
                local new_size_num=${new_disk_size%[GgMm]}
                local current_unit=${DISK_SIZE: -1}
                local new_unit=${new_disk_size: -1}
                
                # Convert both to MB for comparison
                if [[ "$current_unit" =~ [Gg] ]]; then
                    current_size_num=$((current_size_num * 1024))
                fi
                if [[ "$new_unit" =~ [Gg] ]]; then
                    new_size_num=$((new_size_num * 1024))
                fi
                
                if [[ $new_size_num -lt $current_size_num ]]; then
                    print_status "WARN" "Shrinking disk size is not recommended and may cause data loss!"
                    read -p "$(print_status "INPUT" "Are you sure you want to continue? (y/N): ")" confirm_shrink
                    if [[ ! "$confirm_shrink" =~ ^[Yy]$ ]]; then
                        print_status "INFO" "Disk resize cancelled."
                        return 0
                    fi
                fi
                
                # Resize the disk
                print_status "INFO" "Resizing disk to $new_disk_size..."
                if qemu-img resize "$IMG_FILE" "$new_disk_size"; then
                    DISK_SIZE="$new_disk_size"
                    save_vm_config
                    print_status "SUCCESS" "Disk resized successfully to $new_disk_size"
                else
                    print_status "ERROR" "Failed to resize disk"
                    return 1
                fi
                break
            fi
        done
    fi
}

# Function to show VM performance metrics
show_vm_performance() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        if is_vm_running "$vm_name"; then
            print_status "INFO" "Performance metrics for VM: $vm_name"
            echo "=========================================="
            
            # Get QEMU process ID
            local qemu_pid=$(pgrep -f "qemu-system-x86_64.*$IMG_FILE")
            if [[ -n "$qemu_pid" ]]; then
                # Show process stats
                echo "QEMU Process Stats:"
                ps -p "$qemu_pid" -o pid,%cpu,%mem,sz,rss,vsz,cmd --no-headers
                echo
                
                # Show memory usage
                echo "Memory Usage:"
                free -h
                echo
                
                # Show disk usage
                echo "Disk Usage:"
                df -h "$IMG_FILE" 2>/dev/null || du -h "$IMG_FILE"
            else
                print_status "ERROR" "Could not find QEMU process for VM $vm_name"
            fi
        else
            print_status "INFO" "VM $vm_name is not running"
            echo "Configuration:"
            echo "  Memory: $MEMORY MB"
            echo "  CPUs: $CPUS"
            echo "  Disk: $DISK_SIZE"
        fi
        echo "=========================================="
        read -p "$(print_status "INPUT" "Press Enter to continue...")"
    fi
}

# Main menu function
main_menu() {
    while true; do
        display_header
        
        local vms=($(get_vm_list))
        local vm_count=${#vms[@]}
        
        if [ $vm_count -gt 0 ]; then
            print_status "INFO" "Found $vm_count existing VM(s):"
            for i in "${!vms[@]}"; do
                local status="Stopped"
                if is_vm_running "${vms[$i]}"; then
                    status="Running"
                fi
                printf "  %2d) %s (%s)\n" $((i+1)) "${vms[$i]}" "$status"
            done
            echo
        fi
        
        echo -e " ${B_WHITE}${BG_BLUE} MAIN MENU ${RESET}"
        echo
        echo -e " ${B_CYAN}1${RESET} ${ICON_VM}  ${B_GREEN}Create a new VM${RESET}"
        if [ $vm_count -gt 0 ]; then
            echo -e " ${B_CYAN}2${RESET} ${ICON_ROCKET}  ${B_GREEN}Start a VM${RESET}"
            echo -e " ${B_CYAN}3${RESET} ${ICON_WARN}  ${B_YELLOW}Stop a VM${RESET}"
            echo -e " ${B_CYAN}4${RESET} ${ICON_INFO}  ${B_BLUE}Show VM info${RESET}"
            echo -e " ${B_CYAN}5${RESET} ${ICON_GEAR}  ${B_PURPLE}Edit VM configuration${RESET}"
            echo -e " ${B_CYAN}6${RESET} ${ICON_ERROR}  ${B_RED}Delete a VM${RESET}"
            echo -e " ${B_CYAN}7${RESET} ${ICON_BOX}  ${B_CYAN}Resize VM disk${RESET}"
            echo -e " ${B_CYAN}8${RESET} ${ICON_TELE}  ${B_WHITE}Show VM performance${RESET}"
        fi
        echo -e " ${B_RED}0${RESET} ${ICON_ERROR}  ${B_RED}Exit${RESET}"
        echo
        
        read -p "$(print_status "INPUT" "Enter your choice: ")" choice
        
        case $choice in
            1)
                create_new_vm
                ;;
            2)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to start: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        start_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            3)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to stop: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        stop_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            4)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to show info: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        show_vm_info "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            5)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to edit: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        edit_vm_config "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            6)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to delete: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        delete_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            7)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to resize disk: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        resize_vm_disk "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            8)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "Enter VM number to show performance: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        show_vm_performance "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "Invalid selection"
                    fi
                fi
                ;;
            0)
                print_status "INFO" "Goodbye!"
                exit 0
                ;;
            *)
                print_status "ERROR" "Invalid option"
                ;;
        esac
        
        read -p "$(print_status "INPUT" "Press Enter to continue...")"
    done
}

# Set trap to cleanup on exit
trap cleanup EXIT

# Check dependencies
check_dependencies

# Initialize paths
VM_DIR="${VM_DIR:-$HOME/vms}"
mkdir -p "$VM_DIR"

# Supported OS list
declare -A OS_OPTIONS=(
    ["Ubuntu 22.04"]="ubuntu|jammy|https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img|ubuntu22|ubuntu|ubuntu"
    ["Ubuntu 24.04"]="ubuntu|noble|https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img|ubuntu24|ubuntu|ubuntu"
    ["Debian 11"]="debian|bullseye|https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2|debian11|debian|debian"
    ["Debian 12"]="debian|bookworm|https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2|debian12|debian|debian"
    ["Fedora 40"]="fedora|40|https://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-40-1.14.x86_64.qcow2|fedora40|fedora|fedora"
    ["CentOS Stream 9"]="centos|stream9|https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2|centos9|centos|centos"
    ["AlmaLinux 9"]="almalinux|9|https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2|almalinux9|alma|alma"
    ["Rocky Linux 9"]="rockylinux|9|https://download.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2|rocky9|rocky|rocky"
)

# Start the main menu
main_menu

EOF_VM_CONTENT
}

vps_menu() {
    while true; do
        display_submenu_header
        echo -e " ${B_WHITE}${BG_BLUE} VPS RELATED TOOLS ${RESET}"
        echo
        echo -e " ${B_CYAN}1${RESET} ${ICON_VM}  ${B_GREEN}Make VPS in Firebase${RESET}       ${B_BLACK}(Does .idx and VM Manager setup)${RESET}"
        echo -e " ${B_CYAN}2${RESET} ${ICON_BOX}  ${B_PURPLE}Install Proxmox VE${RESET}         ${B_BLACK}(Docker Version)${RESET}"
        echo -e " ${B_CYAN}3${RESET} ${ICON_RDP}  ${B_BLUE}Make xRDP${RESET}                  ${B_BLACK}(XFCE + Firefox)${RESET}"
        echo -e " ${B_CYAN}4${RESET} ${ICON_VM}  ${B_GREEN}Make Real KVM VPS${RESET}        ${B_BLACK}(Sudo Required)${RESET}"
        echo -e " ${B_RED}0${RESET} ${ICON_ERROR}  ${B_RED}Back to Main Menu${RESET}"
        echo
        
        read -p "Enter your choice: " vps_choice
        
        case $vps_choice in
            1)
                mkdir -p .idx
                echo -e "${B_BLUE}${ICON_BOX} Creating .idx folder...${RESET}"
            
                # dev.nix
                cat > .idx/dev.nix <<'EODEV'
{ pkgs, ... }: {
  channel = "stable-24.05";
  packages = with pkgs; [
    unzip openssh git qemu_kvm sudo cdrkit cloud-utils qemu docker
  ];
  env = {
    EDITOR = "nano";
  };
}
EODEV
                echo -e "${B_GREEN}${ICON_CHECK} dev.nix created${RESET}"
            
                # vm.sh
                generate_vm_script > .idx/vm.sh

                chmod +x .idx/vm.sh
                echo -e "${B_GREEN}${ICON_CHECK} vm.sh created in .idx${RESET}"
                echo -e "${B_GREEN}${ICON_CHECK} VM Manager installed${RESET}"
                echo -e "${B_YELLOW}${ICON_INFO} Run it using:${RESET} cd .idx && bash vm.sh"
            ;;
            
            2)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_PURPLE}        ${ICON_BOX} PROXMOX VE (DOCKER VERSION)${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
            
                echo -e "${B_YELLOW}${ICON_GEAR} Updating system...${RESET}"
                apt update && apt upgrade -y
            
                echo -e "${B_YELLOW}${ICON_BOX} Installing Docker...${RESET}"
                apt install -y docker.io
            
                echo -e "${B_YELLOW}${ICON_GEAR} Enabling Docker auto-start...${RESET}"
                systemctl enable docker
                systemctl start docker
            
                echo -e "${B_YELLOW}${ICON_BOX} Pulling Proxmox Docker image...${RESET}"
                docker pull rtedpro/proxmox:9.0.11
            
                echo -e "${B_GREEN}${ICON_ROCKET} Starting Proxmox VE container...${RESET}"
                docker run -itd \
                    --name proxmoxve \
                    --hostname pve \
                    -p 8006:8006 \
                    --privileged \
                    --restart unless-stopped \
                    rtedpro/proxmox:9.0.11
            
                echo -e "${B_GREEN}${ICON_CHECK} Proxmox VE container started!${RESET}"
                echo -e "${B_CYAN}${ICON_INFO} Access it in your browser: https://<your-server-ip>:8006${RESET}"
                echo -e "${B_PURPLE}<3  Made by: Kendrick.${RESET}"
            ;;
            
            3)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_BLUE}        ${ICON_RDP} Installing xRDP + XFCE + Firefox${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
            
                apt update && apt upgrade -y
                apt install -y xfce4 xfce4-goodies xrdp firefox-esr
            
                echo "startxfce4" > ~/.xsession
                sudo chown "$USER:$USER" ~/.xsession
            
                systemctl enable xrdp
                systemctl start xrdp
            
                echo -e "${B_GREEN}${ICON_CHECK} xRDP + XFCE + Firefox installed!${RESET}"
                echo -e "${B_CYAN}${ICON_RDP} Connect via RDP client to your server IP${RESET}"
            ;;
            
            4)
                # Check sudo
                if [ "$EUID" -ne 0 ]; then
                    echo -e "${B_RED}${ICON_ERROR} This option requires sudo privileges!${RESET}"
                    echo -e "${B_YELLOW}Please run the script with sudo.${RESET}"
                    exit 1
                fi

                # Check dependencies and install if missing
                echo -e "${B_BLUE}${ICON_GEAR} Checking requirements...${RESET}"
                local missing_deps=0
                if ! command -v qemu-system-x86_64 &> /dev/null; then missing_deps=1; fi
                if ! command -v cloud-localds &> /dev/null; then missing_deps=1; fi
                if ! command -v qemu-img &> /dev/null; then missing_deps=1; fi
                if ! command -v wget &> /dev/null; then missing_deps=1; fi

                if [ $missing_deps -eq 1 ]; then
                    echo -e "${B_YELLOW}${ICON_WARN} Missing dependencies found.${RESET}"
                    echo -e "${B_BLUE}${ICON_BOX} Installing required packages...${RESET}"
                    apt update && apt install -y qemu-kvm qemu-utils cloud-image-utils wget
                    echo -e "${B_GREEN}${ICON_CHECK} Dependencies installed.${RESET}"
                else
                    echo -e "${B_GREEN}${ICON_CHECK} All requirements met.${RESET}"
                fi

                echo -e "${B_BLUE}${ICON_BOX} Generating VM Manager script...${RESET}"
                generate_vm_script > vm.sh
                chmod +x vm.sh
                echo -e "${B_GREEN}${ICON_ROCKET} Starting VM Manager...${RESET}"
                if [ -f "./vm.sh" ]; then
                    ./vm.sh
                else
                    echo -e "${B_RED}${ICON_ERROR} Failed to generate vm.sh${RESET}"
                fi
            ;;
            
            0)
                return 0
            ;;
            
            *)
                echo -e "${B_RED}${ICON_ERROR} Invalid choice!${RESET}"
            ;;
        esac
        read -p "Press Enter to continue..."
    done
}

# Port Forwarding Menu
port_menu() {
    while true; do
        display_submenu_header
        echo -e " ${B_WHITE}${BG_PURPLE} PORT FORWARDING TOOLS ${RESET}"
        echo
        echo -e " ${B_CYAN}1${RESET} ${ICON_TELE}  ${B_YELLOW}Install Telebit${RESET}            ${B_BLACK}(Port Forwarding)${RESET}"
        echo -e " ${B_CYAN}2${RESET} ${ICON_ROCKET}  ${B_BLUE}Install Cloudflared${RESET}        ${B_BLACK}(Tunneling)${RESET}"
        echo -e " ${B_CYAN}3${RESET} ${ICON_GEAR}  ${B_GREEN}Install Localtonet${RESET}         ${B_BLACK}(One-click)${RESET}"
        echo -e " ${B_CYAN}4${RESET} ${ICON_INFO}  ${B_CYAN}Quick Connect (Serveo)${RESET}     ${B_BLACK}(No Install)${RESET}"
        echo -e " ${B_RED}0${RESET} ${ICON_ERROR}  ${B_RED}Back to Main Menu${RESET}"
        echo
        
        read -p "Enter your choice: " port_choice
        
        case $port_choice in
            1)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_YELLOW}        ${ICON_TELE} Installing Telebit${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
            
                curl -fsSL https://get.telebit.io | bash
                echo -e "${B_GREEN}${ICON_CHECK} Telebit installed!${RESET}"
                echo -e "${B_CYAN}${ICON_INFO} Run it using: telebit help${RESET}"
            ;;
            
            2)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_BLUE}        ${ICON_ROCKET} Installing Cloudflared${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
                
                # Add cloudflare gpg key
                sudo mkdir -p --mode=0755 /usr/share/keyrings
                curl -fsSL https://pkg.cloudflare.com/cloudflare-public-v2.gpg | sudo tee /usr/share/keyrings/cloudflare-public-v2.gpg >/dev/null

                # Add this repo to your apt repositories
                echo 'deb [signed-by=/usr/share/keyrings/cloudflare-public-v2.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

                # install cloudflared
                sudo apt-get update && sudo apt-get install cloudflared
                
                echo -e "${B_GREEN}${ICON_CHECK} Cloudflared installed!${RESET}"
                echo -e "${B_PURPLE}<3  Made by: Kendrick.${RESET}"
            ;;
            
            3)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_GREEN}        ${ICON_GEAR} Installing Localtonet${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
                
                curl -sSL https://localtonet.com/install.sh | bash
                
                echo -e "${B_GREEN}${ICON_CHECK} Localtonet installed!${RESET}"
                echo -e "${B_PURPLE}<3  Made by: Kendrick.${RESET}"
            ;;
            
            4)
                clear
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_CYAN}        ${ICON_INFO} Quick Connect (Serveo)${RESET}"
                echo -e "${B_CYAN}========================================================${RESET}"
                echo -e "${B_YELLOW}No installation required! Run this command:${RESET}"
                echo -e "${B_WHITE}autossh -M 0 -R 80:localhost:3000 serveo.net${RESET}"
                echo -e "${B_PURPLE}<3  Made by: Kendrick.${RESET}"
            ;;
            
            0)
                return 0
            ;;
            
            *)
                echo -e "${B_RED}${ICON_ERROR} Invalid choice!${RESET}"
            ;;
        esac
        read -p "Press Enter to continue..."
    done
}

while true; do
    draw_banner
    
    echo -e " ${B_WHITE}${BG_BLUE} MAIN CATEGORIES ${RESET}"
    echo
    echo -e " ${B_CYAN}1${RESET} ${ICON_VM}  ${B_GREEN}VPS Related Tools${RESET}"
    echo -e " ${B_CYAN}2${RESET} ${ICON_TELE}  ${B_PURPLE}Port Forwarding Tools${RESET}"
    echo -e " ${B_RED}0${RESET} ${ICON_ERROR}  ${B_RED}Exit${RESET}"
    echo

    read -p "Enter your choice: " main_choice

    case $main_choice in
        1)
            vps_menu
            ;;
        2)
            port_menu
            ;;
        0)
            echo -e "${B_RED}${ICON_CHECK} Exiting...${RESET}"
            exit 0
            ;;
        *)
            echo -e "${B_RED}${ICON_ERROR} Invalid choice!${RESET}"
            ;;
    esac
done
