#!/bin/bash
set -euo pipefail

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
ICON_VM="💾"
ICON_RDP="🖥️"

# =============================
# Enhanced Multi-VM Manager (Pure QEMU Version)
# =============================

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
    echo -e "${B_YELLOW}             >>> Ultimate VM Manager Tool <<<   ${RESET}"
    echo -e "${B_BLUE}             ---------------------------------------------   ${RESET}"
    echo
}

# Function to display colored output with emojis
print_status() {
    local type=$1
    local message=$2
    
    case $type in
        "INFO") echo -e "${B_BLUE}[${ICON_INFO} INFO]${RESET}  $message" ;;
        "WARN") echo -e "${B_YELLOW}[${ICON_WARN} WARN]${RESET}  $message" ;;
        "ERROR") echo -e "${B_RED}[${ICON_ERROR} ERROR]${RESET} $message" ;;
        "SUCCESS") echo -e "${B_GREEN}[${ICON_CHECK} OK]${RESET}    $message" ;;
        "INPUT") echo -e "${B_CYAN}[👉 INPUT]${RESET} $message" ;;
        *) echo "[$type] $message" ;;
    esac
}

# Function to check if image file is locked
check_image_lock() {
    local img_file=$1
    local vm_name=$2
    
    # Check if QEMU is already using this image
    if lsof "$img_file" 2>/dev/null | grep -q qemu-system; then
        print_status "WARN" "🔒 Image file $img_file is already in use by another QEMU process"
        
        # Find the process ID
        local pid=$(lsof "$img_file" 2>/dev/null | grep qemu-system | awk '{print $2}' | head -1)
        if [[ -n "$pid" ]]; then
            print_status "INFO" "🔍 Process ID using the image: $pid"
            
            # Check if it's our own VM
            if ps -p "$pid" -o cmd= | grep -q "$vm_name"; then
                print_status "INFO" "🤔 This appears to be the same VM already running"
                read -p "$(print_status "INPUT" "🔄 Kill existing process and restart? (y/N): ")" kill_choice
                if [[ "$kill_choice" =~ ^[Yy]$ ]]; then
                    kill "$pid"
                    sleep 2
                    if kill -0 "$pid" 2>/dev/null; then
                        kill -9 "$pid"
                        print_status "WARN" "⚠️  Forcefully terminated process $pid"
                    fi
                    return 0
                else
                    return 1
                fi
            else
                print_status "ERROR" "🚫 Another QEMU instance is using this image"
                return 1
            fi
        fi
        return 1
    fi
    
    # Check for lock files
    local lock_file="${img_file}.lock"
    if [[ -f "$lock_file" ]]; then
        print_status "WARN" "🔒 Lock file found: $lock_file"
        
        # Check if lock file is stale (older than 5 minutes)
        if [[ $(find "$lock_file" -mmin +5 2>/dev/null) ]]; then
            print_status "WARN" "⏰ Lock file appears stale (older than 5 minutes)"
            read -p "$(print_status "INPUT" "🗑️  Remove stale lock file? (y/N): ")" remove_lock
            if [[ "$remove_lock" =~ ^[Yy]$ ]]; then
                rm -f "$lock_file"
                print_status "SUCCESS" "✅ Removed stale lock file"
                return 0
            else
                return 1
            fi
        fi
        return 1
    fi
    return 0
}

# Function to validate input
validate_input() {
    local type=$1
    local value=$2
    
    case $type in
        "number")
            if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                print_status "ERROR" "❌ Must be a number"
                return 1
            fi
            ;;
        "size")
            if ! [[ "$value" =~ ^[0-9]+[GgMm]$ ]]; then
                print_status "ERROR" "❌ Must be a size with unit (e.g., 100G, 512M)"
                return 1
            fi
            ;;
        "port")
            if ! [[ "$value" =~ ^[0-9]+$ ]] || [ "$value" -lt 23 ] || [ "$value" -gt 65535 ]; then
                print_status "ERROR" "❌ Must be a valid port number (23-65535)"
                return 1
            fi
            ;;
        "name")
            if ! [[ "$value" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                print_status "ERROR" "❌ VM name can only contain letters, numbers, hyphens, and underscores"
                return 1
            fi
            ;;
        "username")
            if ! [[ "$value" =~ ^[a-z_][a-z0-9_-]*$ ]]; then
                print_status "ERROR" "❌ Username must start with a letter or underscore, and contain only letters, numbers, hyphens, and underscores"
                return 1
            fi
            ;;
    esac
    return 0
}

# Function to check dependencies
check_dependencies() {
    local deps=("qemu-system-x86_64" "wget" "cloud-localds" "qemu-img" "lsof")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_status "ERROR" "🔧 Missing dependencies: ${missing_deps[*]}"
        print_status "INFO" "💡 On Ubuntu/Debian, try: sudo apt install qemu-system cloud-image-utils wget lsof"
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
        print_status "ERROR" "📂 Configuration for VM '$vm_name' not found"
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
    
    print_status "SUCCESS" "💾 Configuration saved to $config_file"
}

# Function to create new VM
create_new_vm() {
    print_status "INFO" "🆕 Creating a new VM"
    
    # OS Selection
    print_status "INFO" "🌍 Select an OS to set up:"
    local os_options=()
    local i=1
    for os in "${!OS_OPTIONS[@]}"; do
        echo "  $i) $os"
        os_options[$i]="$os"
        ((i++))
    done
    
    while true; do
        read -p "$(print_status "INPUT" "🎯 Enter your choice (1-${#OS_OPTIONS[@]}): ")" choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#OS_OPTIONS[@]} ]; then
            local os="${os_options[$choice]}"
            IFS='|' read -r OS_TYPE CODENAME IMG_URL DEFAULT_HOSTNAME DEFAULT_USERNAME DEFAULT_PASSWORD <<< "${OS_OPTIONS[$os]}"
            break
        else
            print_status "ERROR" "❌ Invalid selection. Try again."
        fi
    done

    # Custom Inputs with validation
    while true; do
        read -p "$(print_status "INPUT" "🏷️  Enter VM name (default: $DEFAULT_HOSTNAME): ")" VM_NAME
        VM_NAME="${VM_NAME:-$DEFAULT_HOSTNAME}"
        if validate_input "name" "$VM_NAME"; then
            # Check if VM name already exists
            if [[ -f "$VM_DIR/$VM_NAME.conf" ]]; then
                print_status "ERROR" "⚠️  VM with name '$VM_NAME' already exists"
            else
                break
            fi
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "🏠 Enter hostname (default: $VM_NAME): ")" HOSTNAME
        HOSTNAME="${HOSTNAME:-$VM_NAME}"
        if validate_input "name" "$HOSTNAME"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "👤 Enter username (default: $DEFAULT_USERNAME): ")" USERNAME
        USERNAME="${USERNAME:-$DEFAULT_USERNAME}"
        if validate_input "username" "$USERNAME"; then
            break
        fi
    done

    while true; do
        read -s -p "$(print_status "INPUT" "🔑 Enter password (default: $DEFAULT_PASSWORD): ")" PASSWORD
        PASSWORD="${PASSWORD:-$DEFAULT_PASSWORD}"
        echo
        if [ -n "$PASSWORD" ]; then
            break
        else
            print_status "ERROR" "❌ Password cannot be empty"
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "💾 Disk size (default: 20G): ")" DISK_SIZE
        DISK_SIZE="${DISK_SIZE:-20G}"
        if validate_input "size" "$DISK_SIZE"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "🧠 Memory in MB (default: 2048): ")" MEMORY
        MEMORY="${MEMORY:-2048}"
        if validate_input "number" "$MEMORY"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "⚡ Number of CPUs (default: 2): ")" CPUS
        CPUS="${CPUS:-2}"
        if validate_input "number" "$CPUS"; then
            break
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "🔌 SSH Port (default: 2222): ")" SSH_PORT
        SSH_PORT="${SSH_PORT:-2222}"
        if validate_input "port" "$SSH_PORT"; then
            # Check if port is already in use
            if ss -tln 2>/dev/null | grep -q ":$SSH_PORT "; then
                print_status "ERROR" "🚫 Port $SSH_PORT is already in use"
            else
                break
            fi
        fi
    done

    while true; do
        read -p "$(print_status "INPUT" "🖥️  Enable GUI mode? (y/n, default: n): ")" gui_input
        GUI_MODE=false
        gui_input="${gui_input:-n}"
        if [[ "$gui_input" =~ ^[Yy]$ ]]; then 
            GUI_MODE=true
            break
        elif [[ "$gui_input" =~ ^[Nn]$ ]]; then
            break
        else
            print_status "ERROR" "❌ Please answer y or n"
        fi
    done

    # Additional network options
    read -p "$(print_status "INPUT" "🌐 Additional port forwards (e.g., 8080:80, press Enter for none): ")" PORT_FORWARDS

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
    print_status "INFO" "📥 Downloading and preparing image..."
    
    # Create VM directory if it doesn't exist
    mkdir -p "$VM_DIR"
    
    # Check if image already exists
    if [[ -f "$IMG_FILE" ]]; then
        print_status "INFO" "✅ Image file already exists. Skipping download."
    else
        print_status "INFO" "🌐 Downloading image from $IMG_URL..."
        if ! wget --progress=bar:force "$IMG_URL" -O "$IMG_FILE.tmp"; then
            print_status "ERROR" "❌ Failed to download image from $IMG_URL"
            exit 1
        fi
        mv "$IMG_FILE.tmp" "$IMG_FILE"
    fi
    
    # Resize the disk image if needed
    if ! qemu-img resize "$IMG_FILE" "$DISK_SIZE" 2>/dev/null; then
        print_status "WARN" "⚠️  Failed to resize disk image. Creating new image with specified size..."
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
        print_status "ERROR" "❌ Failed to create cloud-init seed image"
        exit 1
    fi
    
    print_status "SUCCESS" "🎉 VM '$VM_NAME' created successfully."
    print_status "INFO" "🔑 Login with: username=$USERNAME, password=$PASSWORD"
    print_status "INFO" "🔌 SSH: ssh -p $SSH_PORT $USERNAME@localhost"
}

# Function to start a VM (Pure QEMU version without KVM)
start_vm() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        # Check if image is already in use
        if ! check_image_lock "$IMG_FILE" "$vm_name"; then
            print_status "ERROR" "🔒 Cannot start VM: Image file is locked by another process"
            read -p "$(print_status "INPUT" "🔄 Do you want to force kill all QEMU processes using this image? (y/N): ")" force_kill
            if [[ "$force_kill" =~ ^[Yy]$ ]]; then
                pkill -f "qemu-system.*$IMG_FILE"
                sleep 2
                if pgrep -f "qemu-system.*$IMG_FILE" >/dev/null; then
                    pkill -9 -f "qemu-system.*$IMG_FILE"
                fi
                print_status "SUCCESS" "✅ Terminated processes using the image"
                # Remove any lock files
                rm -f "${IMG_FILE}.lock" 2>/dev/null
            else
                return 1
            fi
        fi
        
        # Check if VM is already running
        if is_vm_running "$vm_name"; then
            print_status "WARN" "⚠️  VM '$vm_name' is already running"
            read -p "$(print_status "INPUT" "🔄 Stop and restart? (y/N): ")" restart_choice
            if [[ "$restart_choice" =~ ^[Yy]$ ]]; then
                stop_vm "$vm_name"
                sleep 2
            else
                return 1
            fi
        fi
        
        print_status "INFO" "🚀 Starting VM: $vm_name"
        print_status "INFO" "🔌 SSH: ssh -p $SSH_PORT $USERNAME@localhost"
        print_status "INFO" "🔑 Password: $PASSWORD"
        print_status "INFO" "🐌 Running in pure software emulation mode (no KVM)"
        
        # Check if image file exists
        if [[ ! -f "$IMG_FILE" ]]; then
            print_status "ERROR" "❌ VM image file not found: $IMG_FILE"
            return 1
        fi
        
        # Check if seed file exists
        if [[ ! -f "$SEED_FILE" ]]; then
            print_status "WARN" "⚠️  Seed file not found, recreating..."
            setup_vm_image
        fi
        
        # Pure QEMU command without KVM
        local qemu_cmd=(
            qemu-system-x86_64
            -m "$MEMORY"
            -smp "$CPUS"
            -cpu qemu64
            -machine type=pc,accel=tcg
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
            qemu_cmd+=(-vga virtio -display gtk,gl=on)
            print_status "INFO" "🖥️  Starting in GUI mode..."
        else
            qemu_cmd+=(-nographic -serial mon:stdio)
            print_status "INFO" "📟 Starting in console mode..."
            print_status "INFO" "🛑 Press Ctrl+A then X to exit QEMU console"
        fi

        # Add performance enhancements for software emulation
        qemu_cmd+=(
            -device virtio-balloon-pci
            -object rng-random,filename=/dev/urandom,id=rng0
            -device virtio-rng-pci,rng=rng0
            -no-hpet
            -rtc base=utc,clock=host
        )

        print_status "INFO" "⚡ Starting QEMU in pure software emulation mode..."
        echo "📊 Configuration: ${MEMORY}MB RAM, ${CPUS} CPUs, ${DISK_SIZE} disk"
        echo "ℹ️  Note: For better performance, consider enabling KVM if your system supports it"
        
        # Start the VM
        if ! "${qemu_cmd[@]}"; then
            print_status "ERROR" "❌ Failed to start VM. There might be a problem with the image file or configuration."
            # Try to clean up lock files
            rm -f "${IMG_FILE}.lock" 2>/dev/null
            return 1
        fi
        
        print_status "INFO" "🛑 VM $vm_name has been shut down"
    fi
}

# Function to delete a VM
delete_vm() {
    local vm_name=$1
    
    print_status "WARN" "⚠️  ⚠️  ⚠️  This will permanently delete VM '$vm_name' and all its data!"
    read -p "$(print_status "INPUT" "🗑️  Are you sure? (y/N): ")" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if load_vm_config "$vm_name"; then
            # Check if VM is running
            if is_vm_running "$vm_name"; then
                print_status "WARN" "⚠️  VM is currently running. Stopping it first..."
                stop_vm "$vm_name"
                sleep 2
            fi
            
            rm -f "$IMG_FILE" "$SEED_FILE" "$VM_DIR/$vm_name.conf" "${IMG_FILE}.lock" 2>/dev/null
            print_status "SUCCESS" "✅ VM '$vm_name' has been deleted"
        fi
    else
        print_status "INFO" "👍 Deletion cancelled"
    fi
}

# Function to show VM info
show_vm_info() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        echo
        print_status "INFO" "📊 VM Information: $vm_name"
        echo -e "${B_BLUE}═══════════════════════════════════════════${RESET}"
        echo -e "${B_CYAN}🌍 OS:${RESET}            ${B_WHITE}$OS_TYPE${RESET}"
        echo -e "${B_CYAN}🏷️  Hostname:${RESET}     ${B_WHITE}$HOSTNAME${RESET}"
        echo -e "${B_CYAN}👤 Username:${RESET}      ${B_WHITE}$USERNAME${RESET}"
        echo -e "${B_CYAN}🔑 Password:${RESET}      ${B_WHITE}$PASSWORD${RESET}"
        echo -e "${B_CYAN}🔌 SSH Port:${RESET}      ${B_WHITE}$SSH_PORT${RESET}"
        echo -e "${B_CYAN}🧠 Memory:${RESET}        ${B_WHITE}$MEMORY MB${RESET}"
        echo -e "${B_CYAN}⚡ CPUs:${RESET}          ${B_WHITE}$CPUS${RESET}"
        echo -e "${B_CYAN}💾 Disk:${RESET}          ${B_WHITE}$DISK_SIZE${RESET}"
        echo -e "${B_CYAN}🖥️  GUI Mode:${RESET}     ${B_WHITE}$GUI_MODE${RESET}"
        echo -e "${B_CYAN}🌐 Port Forwards:${RESET} ${B_WHITE}${PORT_FORWARDS:-None}${RESET}"
        echo -e "${B_CYAN}📅 Created:${RESET}       ${B_WHITE}$CREATED${RESET}"
        echo -e "${B_CYAN}💿 Image File:${RESET}    ${B_WHITE}$IMG_FILE${RESET}"
        echo -e "${B_CYAN}🌱 Seed File:${RESET}     ${B_WHITE}$SEED_FILE${RESET}"
        
        # Show lock status
        if check_image_lock "$IMG_FILE" "$vm_name" >/dev/null 2>&1; then
            echo -e "${B_GREEN}🔓 Image Status:${RESET}  ${B_WHITE}Unlocked${RESET}"
        else
            echo -e "${B_YELLOW}🔒 Image Status:${RESET}  ${B_WHITE}Locked (possibly in use)${RESET}"
        fi
        
        # Show if VM is running
        if is_vm_running "$vm_name"; then
            echo -e "${B_GREEN}🚀 Status:${RESET}        ${B_WHITE}Running${RESET}"
        else
            echo -e "${B_YELLOW}💤 Status:${RESET}        ${B_WHITE}Stopped${RESET}"
        fi
        
        echo -e "${B_BLUE}═══════════════════════════════════════════${RESET}"
        echo
        read -p "$(print_status "INPUT" "⏎ Press Enter to continue...")"
    fi
}

# Function to check if VM is running
is_vm_running() {
    local vm_name=$1
    
    # First try to find by image file
    if pgrep -f "qemu-system.*$vm_name" >/dev/null; then
        return 0
    fi
    
    # Also check by image file path
    if load_vm_config "$vm_name" 2>/dev/null; then
        if pgrep -f "qemu-system.*$IMG_FILE" >/dev/null; then
            return 0
        fi
    fi
    
    return 1
}

# Function to stop a running VM
stop_vm() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        if is_vm_running "$vm_name"; then
            print_status "INFO" "🛑 Stopping VM: $vm_name"
            
            # Try graceful shutdown first
            pkill -f "qemu-system.*$IMG_FILE"
            sleep 2
            
            # Check if it stopped
            if is_vm_running "$vm_name"; then
                print_status "WARN" "⚠️  VM did not stop gracefully, forcing termination..."
                pkill -9 -f "qemu-system.*$IMG_FILE"
                sleep 1
            fi
            
            # Clean up lock files
            rm -f "${IMG_FILE}.lock" 2>/dev/null
            
            if is_vm_running "$vm_name"; then
                print_status "ERROR" "❌ Failed to stop VM"
                return 1
            else
                print_status "SUCCESS" "✅ VM $vm_name stopped"
            fi
        else
            print_status "INFO" "💤 VM $vm_name is not running"
            # Still try to clean up any lock files
            rm -f "${IMG_FILE}.lock" 2>/dev/null
        fi
    fi
}

# Function to edit VM configuration
edit_vm_config() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        print_status "INFO" "✏️  Editing VM: $vm_name"
        
        while true; do
            echo -e "${B_PURPLE}📝 What would you like to edit?${RESET}"
            echo -e " ${B_CYAN}1${RESET}) 🏷️  ${B_YELLOW}Hostname${RESET}"
            echo -e " ${B_CYAN}2${RESET}) 👤 ${B_YELLOW}Username${RESET}"
            echo -e " ${B_CYAN}3${RESET}) 🔑 ${B_YELLOW}Password${RESET}"
            echo -e " ${B_CYAN}4${RESET}) 🔌 ${B_YELLOW}SSH Port${RESET}"
            echo -e " ${B_CYAN}5${RESET}) 🖥️  ${B_YELLOW}GUI Mode${RESET}"
            echo -e " ${B_CYAN}6${RESET}) 🌐 ${B_YELLOW}Port Forwards${RESET}"
            echo -e " ${B_CYAN}7${RESET}) 🧠 ${B_YELLOW}Memory (RAM)${RESET}"
            echo -e " ${B_CYAN}8${RESET}) ⚡ ${B_YELLOW}CPU Count${RESET}"
            echo -e " ${B_CYAN}9${RESET}) 💾 ${B_YELLOW}Disk Size${RESET}"
            echo -e " ${B_RED}0${RESET}) ↩️  ${B_RED}Back to main menu${RESET}"
            
            read -p "$(print_status "INPUT" "🎯 Enter your choice: ")" edit_choice
            
            case $edit_choice in
                1)
                    while true; do
                        read -p "$(print_status "INPUT" "🏷️  Enter new hostname (current: $HOSTNAME): ")" new_hostname
                        new_hostname="${new_hostname:-$HOSTNAME}"
                        if validate_input "name" "$new_hostname"; then
                            HOSTNAME="$new_hostname"
                            break
                        fi
                    done
                    ;;
                2)
                    while true; do
                        read -p "$(print_status "INPUT" "👤 Enter new username (current: $USERNAME): ")" new_username
                        new_username="${new_username:-$USERNAME}"
                        if validate_input "username" "$new_username"; then
                            USERNAME="$new_username"
                            break
                        fi
                    done
                    ;;
                3)
                    while true; do
                        read -s -p "$(print_status "INPUT" "🔑 Enter new password (current: ****): ")" new_password
                        new_password="${new_password:-$PASSWORD}"
                        echo
                        if [ -n "$new_password" ]; then
                            PASSWORD="$new_password"
                            break
                        else
                            print_status "ERROR" "❌ Password cannot be empty"
                        fi
                    done
                    ;;
                4)
                    while true; do
                        read -p "$(print_status "INPUT" "🔌 Enter new SSH port (current: $SSH_PORT): ")" new_ssh_port
                        new_ssh_port="${new_ssh_port:-$SSH_PORT}"
                        if validate_input "port" "$new_ssh_port"; then
                            # Check if port is already in use
                            if [ "$new_ssh_port" != "$SSH_PORT" ] && ss -tln 2>/dev/null | grep -q ":$new_ssh_port "; then
                                print_status "ERROR" "🚫 Port $new_ssh_port is already in use"
                            else
                                SSH_PORT="$new_ssh_port"
                                break
                            fi
                        fi
                    done
                    ;;
                5)
                    while true; do
                        read -p "$(print_status "INPUT" "🖥️  Enable GUI mode? (y/n, current: $GUI_MODE): ")" gui_input
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
                            print_status "ERROR" "❌ Please answer y or n"
                        fi
                    done
                    ;;
                6)
                    read -p "$(print_status "INPUT" "🌐 Additional port forwards (current: ${PORT_FORWARDS:-None}): ")" new_port_forwards
                    PORT_FORWARDS="${new_port_forwards:-$PORT_FORWARDS}"
                    ;;
                7)
                    while true; do
                        read -p "$(print_status "INPUT" "🧠 Enter new memory in MB (current: $MEMORY): ")" new_memory
                        new_memory="${new_memory:-$MEMORY}"
                        if validate_input "number" "$new_memory"; then
                            MEMORY="$new_memory"
                            break
                        fi
                    done
                    ;;
                8)
                    while true; do
                        read -p "$(print_status "INPUT" "⚡ Enter new CPU count (current: $CPUS): ")" new_cpus
                        new_cpus="${new_cpus:-$CPUS}"
                        if validate_input "number" "$new_cpus"; then
                            CPUS="$new_cpus"
                            break
                        fi
                    done
                    ;;
                9)
                    while true; do
                        read -p "$(print_status "INPUT" "💾 Enter new disk size (current: $DISK_SIZE): ")" new_disk_size
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
                    print_status "ERROR" "❌ Invalid selection"
                    continue
                    ;;
            esac
            
            # Recreate seed image with new configuration if user/password/hostname changed
            if [[ "$edit_choice" -eq 1 || "$edit_choice" -eq 2 || "$edit_choice" -eq 3 ]]; then
                print_status "INFO" "🔄 Updating cloud-init configuration..."
                setup_vm_image
            fi
            
            # Save configuration
            save_vm_config
            
            read -p "$(print_status "INPUT" "🔄 Continue editing? (y/N): ")" continue_editing
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
        # Check if VM is running
        if is_vm_running "$vm_name"; then
            print_status "ERROR" "❌ Cannot resize disk while VM is running. Please stop the VM first."
            return 1
        fi
        
        print_status "INFO" "💾 Current disk size: $DISK_SIZE"
        
        while true; do
            read -p "$(print_status "INPUT" "📈 Enter new disk size (e.g., 50G): ")" new_disk_size
            if validate_input "size" "$new_disk_size"; then
                if [[ "$new_disk_size" == "$DISK_SIZE" ]]; then
                    print_status "INFO" "ℹ️  New disk size is the same as current size. No changes made."
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
                    print_status "WARN" "⚠️  Shrinking disk size is not recommended and may cause data loss!"
                    read -p "$(print_status "INPUT" "⚠️  Are you sure you want to continue? (y/N): ")" confirm_shrink
                    if [[ ! "$confirm_shrink" =~ ^[Yy]$ ]]; then
                        print_status "INFO" "👍 Disk resize cancelled."
                        return 0
                    fi
                fi
                
                # Resize the disk
                print_status "INFO" "📈 Resizing disk to $new_disk_size..."
                if qemu-img resize "$IMG_FILE" "$new_disk_size"; then
                    DISK_SIZE="$new_disk_size"
                    save_vm_config
                    print_status "SUCCESS" "✅ Disk resized successfully to $new_disk_size"
                else
                    print_status "ERROR" "❌ Failed to resize disk"
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
            print_status "INFO" "📊 Performance metrics for VM: $vm_name"
            echo "📈📈📈📈📈📈📈📈📈📈📈📈📈📈📈"
            
            # Get QEMU process ID
            local qemu_pid=$(pgrep -f "qemu-system.*$IMG_FILE")
            if [[ -n "$qemu_pid" ]]; then
                # Show process stats
                echo "⚡ QEMU Process Stats:"
                ps -p "$qemu_pid" -o pid,%cpu,%mem,sz,rss,vsz,cmd --no-headers
                echo
                
                # Show memory usage
                echo "🧠 Memory Usage:"
                free -h
                echo
                
                # Show disk usage
                echo "💾 Disk Usage:"
                df -h "$IMG_FILE" 2>/dev/null || du -h "$IMG_FILE"
            else
                print_status "ERROR" "❌ Could not find QEMU process for VM $vm_name"
            fi
        else
            print_status "INFO" "💤 VM $vm_name is not running"
            echo "⚙️  Configuration:"
            echo "  🧠 Memory: $MEMORY MB"
            echo "  ⚡ CPUs: $CPUS"
            echo "  💾 Disk: $DISK_SIZE"
        fi
        echo "📈📈📈📈📈📈📈📈📈📈📈📈📈📈📈"
        read -p "$(print_status "INPUT" "⏎ Press Enter to continue...")"
    fi
}

# Function to fix VM issues
fix_vm_issues() {
    local vm_name=$1
    
    if load_vm_config "$vm_name"; then
        print_status "INFO" "🔧 Fixing issues for VM: $vm_name"
        
        echo -e "${B_PURPLE}🔧 Select issue to fix:${RESET}"
        echo -e " ${B_CYAN}1${RESET}) 🔓 ${B_YELLOW}Remove lock files${RESET}"
        echo -e " ${B_CYAN}2${RESET}) 🗑️  ${B_YELLOW}Recreate seed image${RESET}"
        echo -e " ${B_CYAN}3${RESET}) 🔄 ${B_YELLOW}Recreate configuration${RESET}"
        echo -e " ${B_CYAN}4${RESET}) 💀 ${B_YELLOW}Kill stuck processes${RESET}"
        echo -e " ${B_RED}0${RESET}) ↩️  ${B_RED}Back${RESET}"
        
        read -p "$(print_status "INPUT" "🎯 Enter your choice: ")" fix_choice
        
        case $fix_choice in
            1)
                print_status "INFO" "🔓 Removing lock files..."
                rm -f "${IMG_FILE}.lock" 2>/dev/null
                rm -f "${IMG_FILE}"*.lock 2>/dev/null
                print_status "SUCCESS" "✅ Lock files removed"
                ;;
            2)
                print_status "INFO" "🔄 Recreating seed image..."
                if [[ -f "$SEED_FILE" ]]; then
                    rm -f "$SEED_FILE"
                fi
                setup_vm_image
                print_status "SUCCESS" "✅ Seed image recreated"
                ;;
            3)
                print_status "INFO" "🔄 Recreating configuration..."
                save_vm_config
                print_status "SUCCESS" "✅ Configuration recreated"
                ;;
            4)
                print_status "INFO" "💀 Killing stuck processes..."
                pkill -f "qemu-system.*$IMG_FILE" 2>/dev/null
                sleep 1
                if pgrep -f "qemu-system.*$IMG_FILE" >/dev/null; then
                    pkill -9 -f "qemu-system.*$IMG_FILE" 2>/dev/null
                    print_status "SUCCESS" "✅ Forcefully killed stuck processes"
                else
                    print_status "INFO" "💤 No stuck processes found"
                fi
                ;;
            0)
                return 0
                ;;
            *)
                print_status "ERROR" "❌ Invalid selection"
                ;;
        esac
    fi
}

# Main menu function
main_menu() {
    while true; do
        display_header
        
        local vms=($(get_vm_list))
        local vm_count=${#vms[@]}
        
        if [ $vm_count -gt 0 ]; then
            print_status "INFO" "📁 Found $vm_count existing VM(s):"
            for i in "${!vms[@]}"; do
                local status="💤"
                if is_vm_running "${vms[$i]}"; then
                    status="🚀"
                fi
                printf "  ${B_CYAN}%2d${RESET}) ${B_WHITE}%s${RESET} %s\n" $((i+1)) "${vms[$i]}" "$status"
            done
            echo
        fi
        
        echo -e " ${B_WHITE}${BG_BLUE} MAIN MENU ${RESET}"
        echo
        echo -e " ${B_CYAN}1${RESET} ${ICON_VM}  ${B_GREEN}Create a new VM${RESET}"
        if [ $vm_count -gt 0 ]; then
            echo -e " ${B_CYAN}2${RESET} ${ICON_ROCKET}  ${B_YELLOW}Start a VM${RESET}"
            echo -e " ${B_CYAN}3${RESET} 🛑  ${B_RED}Stop a VM${RESET}"
            echo -e " ${B_CYAN}4${RESET} ${ICON_INFO}  ${B_BLUE}Show VM info${RESET}"
            echo -e " ${B_CYAN}5${RESET} ✏️   ${B_PURPLE}Edit VM configuration${RESET}"
            echo -e " ${B_CYAN}6${RESET} 🗑️   ${B_RED}Delete a VM${RESET}"
            echo -e " ${B_CYAN}7${RESET} 📈  ${B_YELLOW}Resize VM disk${RESET}"
            echo -e " ${B_CYAN}8${RESET} 📊  ${B_GREEN}Show VM performance${RESET}"
            echo -e " ${B_CYAN}9${RESET} ${ICON_GEAR}  ${B_CYAN}Fix VM issues${RESET}"
        fi
        echo -e " ${B_RED}0${RESET} 👋  ${B_RED}Exit${RESET}"
        echo
        
        read -p "$(print_status "INPUT" "🎯 Enter your choice: ")" choice
        
        case $choice in
            1)
                create_new_vm
                ;;
            2)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "🚀 Enter VM number to start: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        start_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            3)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "🛑 Enter VM number to stop: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        stop_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            4)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "📊 Enter VM number to show info: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        show_vm_info "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            5)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "✏️  Enter VM number to edit: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        edit_vm_config "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            6)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "🗑️  Enter VM number to delete: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        delete_vm "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            7)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "📈 Enter VM number to resize disk: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        resize_vm_disk "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            8)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "📊 Enter VM number to show performance: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        show_vm_performance "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            9)
                if [ $vm_count -gt 0 ]; then
                    read -p "$(print_status "INPUT" "🔧 Enter VM number to fix issues: ")" vm_num
                    if [[ "$vm_num" =~ ^[0-9]+$ ]] && [ "$vm_num" -ge 1 ] && [ "$vm_num" -le $vm_count ]; then
                        fix_vm_issues "${vms[$((vm_num-1))]}"
                    else
                        print_status "ERROR" "❌ Invalid selection"
                    fi
                fi
                ;;
            0)
                print_status "INFO" "👋 Goodbye!"
                exit 0
                ;;
            *)
                print_status "ERROR" "❌ Invalid option"
                ;;
        esac
        
        read -p "$(print_status "INPUT" "⏎ Press Enter to continue...")"
    done
}

# Set trap to cleanup on exit
trap cleanup EXIT

# Check dependencies
check_dependencies

# Initialize paths
VM_DIR="${VM_DIR:-$HOME/vms}"
mkdir -p "$VM_DIR"

# Supported OS list - UPDATED WITH DEBIAN 13
declare -A OS_OPTIONS=(
    ["Ubuntu 22.04"]="ubuntu|jammy|https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img|ubuntu22|ubuntu|ubuntu"
    ["Ubuntu 24.04"]="ubuntu|noble|https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img|ubuntu24|ubuntu|ubuntu"
    ["Debian 11"]="debian|bullseye|https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2|debian11|debian|debian"
    ["Debian 12"]="debian|bookworm|https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2|debian12|debian|debian"
    ["Debian 13"]="debian|trixie|https://cloud.debian.org/images/cloud/trixie/daily/latest/debian-13-generic-amd64-daily.qcow2|debian13|debian|debian"
    ["Fedora 40"]="fedora|40|https://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-40-1.14.x86_64.qcow2|fedora40|fedora|fedora"
    ["CentOS Stream 9"]="centos|stream9|https://cloud.centos.org/centos/9-stream/x86_64/images/CentOS-Stream-GenericCloud-9-latest.x86_64.qcow2|centos9|centos|centos"
    ["AlmaLinux 9"]="almalinux|9|https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2|almalinux9|alma|alma"
    ["Rocky Linux 9"]="rockylinux|9|https://download.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2|rocky9|rocky|rocky"
)

# Start the main menu
main_menu
