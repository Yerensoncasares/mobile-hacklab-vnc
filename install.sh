#!/data/data/com.termux/files/usr/bin/bash
#######################################################
#  📱 MOBILE HACKING LAB - Ultimate VNC Installer v2.0
#  
#  Features:
#  - TigerVNC Server implementation (replaces Termux-X11)
#  - Forced llvmpipe software rendering (fixes GLX/Zink errors)
#  - Optimized for TV Smart clients (like bVNC)
#  
#  Author: Tech Jarves - Modified for VNC
#  YouTube: https://youtube.com/@TechJarves
#######################################################
# ============== CONFIGURATION ==============
TOTAL_STEPS=12
CURRENT_STEP=0
# ============== COLORS ==============
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m'
BOLD='\033[1m'
# ============== PROGRESS FUNCTIONS ==============
update_progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    PERCENT=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    
    FILLED=$((PERCENT / 5))
    EMPTY=$((20 - FILLED))
    
    BAR="${GREEN}"
    for ((i=0; i<FILLED; i++)); do BAR+="█"; done
    BAR+="${GRAY}"
    for ((i=0; i<EMPTY; i++)); do BAR+="░"; done
    BAR+="${NC}"
    
    echo ""
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  📊 OVERALL PROGRESS: ${WHITE}Step ${CURRENT_STEP}/${TOTAL_STEPS}${NC} ${BAR} ${WHITE}${PERCENT}%${NC}"
    echo -e "${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}
spinner() {
    local pid=$1
    local message=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 10 ))
        printf "\r  ${YELLOW}⏳${NC} ${message} ${CYAN}${spin:$i:1}${NC}  "
        sleep 0.1
    done
    
    wait $pid
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        printf "\r  ${GREEN}✓${NC} ${message}                    \n"
    else
        printf "\r  ${RED}✗${NC} ${message} ${RED}(failed)${NC}     \n"
    fi
    return $exit_code
}
install_pkg() {
    local pkg=$1
    local name=${2:-$pkg}
    
    (yes | pkg install $pkg -y > /dev/null 2>&1) &
    spinner $! "Installing ${name}..."
}
# ============== BANNER ==============
show_banner() {
    clear
    echo -e "${CYAN}"
    cat << 'BANNER'
    ╔══════════════════════════════════════╗
    ║                                      ║
    ║   🚀  MOBILE HACKLAB v2.1  🚀        ║
    ║        (VNC EDITION FOR TV)          ║
    ║                                      ║
    ╚══════════════════════════════════════╝
BANNER
    echo -e "${NC}"
    echo -e "${WHITE}         Tech Jarves - Modified for VNC${NC}"
    echo ""
}
# ============== DEVICE DETECTION ==============
detect_device() {
    echo -e "${PURPLE}[*] Detecting your device...${NC}"
    echo ""
    
    DEVICE_MODEL=$(getprop ro.product.model 2>/dev/null || echo "Unknown")
    DEVICE_BRAND=$(getprop ro.product.brand 2>/dev/null || echo "Unknown")
    ANDROID_VERSION=$(getprop ro.build.version.release 2>/dev/null || echo "Unknown")
    CPU_ABI=$(getprop ro.product.cpu.abi 2>/dev/null || echo "arm64-v8a")
    
    echo -e "  ${GREEN}📱${NC} Device: ${WHITE}${DEVICE_BRAND} ${DEVICE_MODEL}${NC}"
    echo -e "  ${GREEN}🤖${NC} Android: ${WHITE}${ANDROID_VERSION}${NC}"
    echo -e "  ${GREEN}⚙️${NC}  CPU: ${WHITE}${CPU_ABI}${NC}"
    echo -e "  ${GREEN}🎮${NC} GPU Driver: ${WHITE}Safe Software Rendering (llvmpipe)${NC}"
    echo ""
    sleep 1
}
# ============== STEP 1: UPDATE SYSTEM ==============
step_update() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Updating system packages...${NC}"
    echo ""
    
    (yes | pkg update -y > /dev/null 2>&1) &
    spinner $! "Updating package lists..."
    
    (yes | pkg upgrade -y > /dev/null 2>&1) &
    spinner $! "Upgrading installed packages..."
}
# ============== STEP 2: INSTALL REPOSITORIES ==============
step_repos() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Adding package repositories...${NC}"
    echo ""
    
    install_pkg "x11-repo" "X11 Repository"
    install_pkg "tur-repo" "TUR Repository (Firefox, VS Code)"
}
# ============== STEP 3: INSTALL TIGERVNC SERVER ==============
step_vnc() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing TigerVNC Server...${NC}"
    echo ""
    
    install_pkg "tigervnc" "TigerVNC Display Server"
}
# ============== STEP 4: INSTALL DESKTOP ==============
step_desktop() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing XFCE4 Desktop...${NC}"
    echo ""
    
    install_pkg "xfce4" "XFCE4 Desktop Environment"
    install_pkg "xfce4-terminal" "XFCE4 Terminal"
    install_pkg "thunar" "Thunar File Manager"
    install_pkg "mousepad" "Mousepad Text Editor"
}
# ============== STEP 5: INSTALL AUDIO ==============
step_audio() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing Audio Support...${NC}"
    echo ""
    
    install_pkg "pulseaudio" "PulseAudio Sound Server"
}
# ============== STEP 6: INSTALL BROWSERS & APPS ==============
step_apps() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing Applications...${NC}"
    echo ""
    
    install_pkg "firefox" "Firefox Browser"
    install_pkg "code-oss" "VS Code Editor"
    install_pkg "git" "Git Version Control"
    install_pkg "wget" "Wget Downloader"
    install_pkg "curl" "cURL"
}
# ============== STEP 7: INSTALL NETWORK TOOLS ==============
step_network_tools() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing Network Scanning Tools...${NC}"
    echo ""
    
    install_pkg "nmap" "Nmap Network Scanner"
    install_pkg "netcat-openbsd" "Netcat"
    install_pkg "whois" "Whois Lookup"
    install_pkg "dnsutils" "DNS Utilities"
    install_pkg "tracepath" "Tracepath"
}
# ============== STEP 8: INSTALL SECURITY TOOLS ==============
step_security_tools() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing Security Tools...${NC}"
    echo ""
    
    install_pkg "hydra" "Hydra Password Cracker"
    install_pkg "john" "John the Ripper"
    install_pkg "sqlmap" "SQLMap (SQL Injection)"
    
    echo -e "  ${YELLOW}⏳${NC} Installing Python security libraries..."
    pip install requests beautifulsoup4 > /dev/null 2>&1
    echo -e "  ${GREEN}✓${NC} Python libraries installed"
}
# ============== STEP 9: INSTALL WINE (WINDOWS APPS) ==============
step_wine() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Installing Wine (Windows Support)...${NC}"
    echo ""
    
    (pkg remove wine-stable -y > /dev/null 2>&1) &
    spinner $! "Removing old Wine versions..."
    
    install_pkg "hangover-wine" "Wine Compatibility Layer"
    install_pkg "hangover-wowbox64" "Box64 Wrapper"
    
    ln -sf /data/data/com.termux/files/usr/opt/hangover-wine/bin/wine /data/data/com.termux/files/usr/bin/wine
    ln -sf /data/data/com.termux/files/usr/opt/hangover-wine/bin/winecfg /data/data/com.termux/files/usr/bin/winecfg
    
    echo -e "  ${YELLOW}⏳${NC} Applying Windows UI optimizations..."
    export GALLIUM_DRIVER=llvmpipe
    wine reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f > /dev/null 2>&1
    echo -e "  ${GREEN}✓${NC} UI optimized"
}
# ============== STEP 10: CREATE LAUNCHER SCRIPTS ==============
step_launchers() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Creating Launcher Scripts...${NC}"
    echo ""
    
    # Secure GPU config (Forcing software rendering to prevent GLX leaks)
    mkdir -p ~/.config
    cat > ~/.config/hacklab-gpu.sh << 'GPUEOF'
# Mobile HackLab - Stable VNC Rendering Config
export GALLIUM_DRIVER=llvmpipe
export MESA_LOADER_DRIVER_OVERRIDE=swrast
export MESA_NO_ERROR=1
GPUEOF
    echo -e "  ${GREEN}✓${NC} GPU Config generated"
    
    # Configure VNC startup environment
    mkdir -p ~/.vnc
    cat > ~/.vnc/xstartup << 'XSTARTEOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
source ~/.config/hacklab-gpu.sh 2>/dev/null
exec startxfce4 &
XSTARTEOF
    chmod +x ~/.vnc/xstartup
    echo -e "  ${GREEN}✓${NC} VNC xstartup generated"
    
    # Main Desktop Launcher with VNC Engine
    cat > ~/start-hacklab.sh << 'LAUNCHEREOF'
#!/data/data/com.termux/files/usr/bin/bash
echo ""
echo "🚀 Starting Mobile HackLab VNC Server..."
echo ""
source ~/.config/hacklab-gpu.sh 2>/dev/null

# Clean up existing sessions
echo "🔄 Cleaning up old sessions..."
vncserver -kill :1 >/dev/null 2>&1
pkill -9 -f "xfce" 2>/dev/null
pkill -9 -f "dbus" 2>/dev/null

# === AUDIO SETUP ===
unset PULSE_SERVER
pulseaudio --kill 2>/dev/null
sleep 0.5
echo "🔊 Starting audio server..."
pulseaudio --start --exit-idle-time=-1
sleep 1
pactl load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1 2>/dev/null
export PULSE_SERVER=127.0.0.1
# === END AUDIO ===

# Start TigerVNC Server
echo "📺 Launching VNC desktop server on port :1..."
# If password isn't set, vncserver will prompt the user to set one
vncserver :1 -geometry 1280x720 -depth 24
sleep 2

# IP Detection for TV Connection
MY_IP=$(ifconfig wlan0 2>/dev/null | grep "inet " | awk '{print $2}')
if [ -z "$MY_IP" ]; then
    MY_IP="[Your-Phone-IP]"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🖥️  DESKTOP ACTIVE ON VNC SERVER"
echo "  "
echo "  🔗 Connection details for your TV Client:"
echo "  👉 Address/IP: $MY_IP"
echo "  👉 Port: 5901 (or Display :1)"
echo "  👉 Password: (The one you defined just now)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
LAUNCHEREOF
    chmod +x ~/start-hacklab.sh
    echo -e "  ${GREEN}✓${NC} Created ~/start-hacklab.sh"
    
    # Quick Tools Menu
    cat > ~/hacktools.sh << 'TOOLSEOF'
#!/data/data/com.termux/files/usr/bin/bash
while true; do
    clear
    echo ""
    echo "╔═══════════════════════════════════════════╗"
    echo "║     🔧 Mobile HackLab - Quick Tools       ║"
    echo "╠═══════════════════════════════════════════╣"
    echo "║  1) 🌐 Nmap - Network Scan                ║"
    echo "║  2) 💉 SQLMap - SQL Injection             ║"
    echo "║  3) 🔑 Hydra - Password Attack            ║"
    echo "║  4) 🖥️  Start VNC Desktop                  ║"
    echo "║  0) ❌ Exit                               ║"
    echo "╚═══════════════════════════════════════════╝"
    echo ""
    read -p "  Select option: " choice
    
    case $choice in
        1) 
            read -p "  Enter target IP/hostname: " target
            nmap -sV $target
            read -p "Press Enter to continue..."
            ;;
        2) 
            read -p "  Enter vulnerable URL: " url
            sqlmap -u "$url" --batch
            read -p "Press Enter to continue..."
            ;;
        3) 
            echo "  Example: hydra -l admin -P wordlist.txt 192.168.1.1 ssh"
            read -p "Press Enter to continue..."
            ;;
        4) 
            bash ~/start-hacklab.sh
            read -p "Press Enter to continue..."
            ;;
        0) 
            exit 0
            ;;
    esac
done
TOOLSEOF
    chmod +x ~/hacktools.sh
    echo -e "  ${GREEN}✓${NC} Created ~/hacktools.sh"
    
    # Desktop Shutdown Script
    cat > ~/stop-hacklab.sh << 'STOPEOF'
#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping Mobile HackLab VNC Server..."
vncserver -kill :1 >/dev/null 2>&1
pkill -9 -f "pulseaudio" 2>/dev/null
pkill -9 -f "xfce" 2>/dev/null
pkill -9 -f "dbus" 2>/dev/null
echo "VNC Desktop stopped."
STOPEOF
    chmod +x ~/stop-hacklab.sh
    echo -e "  ${GREEN}✓${NC} Created ~/stop-hacklab.sh"
}
# ============== STEP 11: CREATE DESKTOP SHORTCUTS ==============
step_shortcuts() {
    update_progress
    echo -e "${PURPLE}[Step ${CURRENT_STEP}/${TOTAL_STEPS}] Creating Desktop Shortcuts...${NC}"
    echo ""
    
    mkdir -p ~/Desktop
    
    # Firefox
    cat > ~/Desktop/Firefox.desktop << 'EOF'
[Desktop Entry]
Name=Firefox
Comment=Web Browser
Exec=firefox
Icon=firefox
Type=Application
Categories=Network;WebBrowser;
EOF
    
    # VS Code
    cat > ~/Desktop/VSCode.desktop << 'EOF'
[Desktop Entry]
Name=VS Code
Comment=Code Editor
Exec=code-oss --no-sandbox
Icon=code-oss
Type=Application
Categories=Development;
EOF
    
    # Terminal
    cat > ~/Desktop/Terminal.desktop << 'EOF'
[Desktop Entry]
Name=Terminal
Comment=XFCE Terminal
Exec=xfce4-terminal
Icon=utilities-terminal
Type=Application
Categories=System;TerminalEmulator;
EOF
    
    # HackTools Menu
    cat > ~/Desktop/HackTools.desktop << 'EOF'
[Desktop Entry]
Name=HackTools Menu
Comment=Quick Security Tools
Exec=xfce4-terminal -e "bash ~/hacktools.sh"
Icon=security-high
Type=Application
Categories=Security;
EOF
    
    # Windows File Explorer
    cat > ~/Desktop/Windows_Explorer.desktop << 'EOF'
[Desktop Entry]
Name=Windows Explorer
Comment=Windows File Manager
Exec=wine winefile
Icon=folder-windows
Type=Application
Categories=System;
EOF
    # Wine Config
    cat > ~/Desktop/Wine_Config.desktop << 'EOF'
[Desktop Entry]
Name=Wine Config
Comment=Windows Settings
Exec=wine winecfg
Icon=wine
Type=Application
Categories=Settings;
EOF
    chmod +x ~/Desktop/*.desktop 2>/dev/null
    echo -e "  ${GREEN}✓${NC} Desktop shortcuts created"
}
# ============== STEP 12: COMPLETION ==============
show_completion() {
    update_progress
    echo ""
    echo -e "${GREEN}"
    cat << 'COMPLETE'
    
    ╔═══════════════════════════════════════════════════════════════╗
    ║                                                               ║
    ║         ✅  INSTALLATION COMPLETE!  ✅                        ║
    ║                                                               ║
    ║              🎉 100% - All Done! 🎉                           ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════╝
    
COMPLETE
    echo -e "${NC}"
    
    echo -e "${WHITE}📱 Your Mobile Hacking Lab is ready!${NC}"
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${WHITE}🚀 TO START THE DESKTOP:${NC}"
    echo -e "   ${GREEN}bash ~/start-hacklab.sh${NC}"
    echo ""
    echo -e "${WHITE}🔧 FOR QUICK TOOLS MENU:${NC}"
    echo -e "   ${GREEN}bash ~/hacktools.sh${NC}"
    echo ""
    echo -e "${WHITE}🛑 TO STOP THE DESKTOP:${NC}"
    echo -e "   ${GREEN}bash ~/stop-hacklab.sh${NC}"
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${CYAN}📦 INSTALLED TOOLS:${NC}"
    echo -e "   • Nmap, Netcat, DNS tools"
    echo -e "   • SQLMap, Hydra, John the Ripper"
    echo -e "   • Firefox, VS Code, Git"
    echo -e "   • Windows Compatibility (Wine/Hangover)"
    echo -e "   • XFCE4 Desktop with TigerVNC"
    echo ""
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  📺 Subscribe: https://youtube.com/@TechJarves${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${WHITE}⚡ TIP: The first time you run start-hacklab.sh, it will ask you to set a password. Then connect your TV client to your phone's IP on port 5901.${NC}"
    echo ""
}
# ============== MAIN INSTALLATION ==============
main() {
    show_banner
    
    echo -e "${WHITE}  This script will install a complete Linux desktop (VNC)${NC}"
    echo -e "${WHITE}  with hacking tools on your Android phone.${NC}"
    echo ""
    echo -e "${GRAY}  Estimated time: 10-20 minutes (depends on internet speed)${NC}"
    echo ""
    echo -e "${YELLOW}  Press Enter to start installation, or Ctrl+C to cancel...${NC}"
    read
    
    detect_device
    step_update
    step_repos
    step_vnc
    step_desktop
    step_audio
    step_apps
    step_network_tools
    step_security_tools
    step_wine
    step_launchers
    step_shortcuts
    show_completion
}
# ============== RUN ==============
main

