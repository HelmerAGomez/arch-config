#!/usr/bin/env bash

# --- 1. Options (Reduced to 3) ---
shutdown='  Power Off'
reboot='  Reboot'
logout='󰍃  Logout'

# --- 2. The One-Click Styled Rofi Command ---
rofi_cmd() {
    rofi -dmenu \
        -hover-select \
        -me-select-entry '' \
        -me-accept-entry 'MousePrimary' \
        -theme-str "
            * {
                bg: #11111b;
                fg: #cdd6f4;
                accent: #89b4fa;
                font: \"JetBrainsMono Nerd Font 12\"; /* Change '12' to '14' or '16' if still too small */
            }
            window { 
                location: center; 
                anchor: center; 
                x-offset: 0px; 
                y-offset: 0px; 
                width: 400px;           /* Wider for a cleaner look */
                border: 2px; 
                border-color: @accent; 
                border-radius: 15px; 
                background-color: @bg;
                padding: 15px;
            }
            mainbox { 
                children: [ listview ]; 
                background-color: transparent; 
            }
            listview { 
                lines: 3;               /* Updated to match 3 options */
                spacing: 12px;          /* Significant gap between buttons */
                padding: 5px; 
                background-color: transparent; 
                fixed-height: true;
            }
            element { 
                padding: 15px 20px;     /* Chunky, easy-to-click buttons */
                border-radius: 10px; 
                background-color: transparent; 
                text-color: @fg; 
            }
            element selected { 
                background-color: @accent; 
                text-color: @bg; 
            }
            element-text { 
                background-color: inherit; 
                text-color: inherit; 
                vertical-align: 0.5; 
                margin: 0px 15px;       /* Pushes text away from icons */
            }
        "
}

# --- 3. Run & Execute ---
chosen=$(echo -e "$shutdown\n$reboot\n$logout" | rofi_cmd)

case ${chosen} in
    *Power*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Logout*) hyprctl dispatch exit 0 ;;
esac