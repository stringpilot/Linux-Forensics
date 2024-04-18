#!/bin/bash

# Define the output file
output_file="investigation_output.txt"

# Function to update the output file
update_output() {
    echo '-------------------------------------------' >> "$output_file"
    echo '-------------------------------------------' >> "$output_file"
    echo "[+] Timestamp: $(date)" >> "$output_file"
    echo '-------------------------------------------' >> "$output_file"
    echo '-------------------------------------------' >> "$output_file"
    echo "$1" >> "$output_file"
    echo '-------------------------------------------' >> "$output_file"
    echo '-------------------------------------------' >> "$output_file"
}

# Bash automation to investigate a live host

echo 'Tools for Live host investigation on unix' > "$output_file"
echo 'Ensure you have sudo privs' >> "$output_file"

while true; do
    echo "What would you like to do next?"
    read -r action

    case $action in
        "sysinfo")
            update_output "[+] live system information"
            hostnamectl >> "$output_file"
            uname -r >> "$output_file"
            date +"%Z %z" >> "$output_file"
            ip a >> "$output_file"
            ;;
        "routing")
            update_output "[+] Display the routing table"
            if ! command -v netstat &> /dev/null; then
                ip route >> "$output_file"
            else
                netstat -r >> "$output_file"
            fi
            ;;
        "shutdown")
            update_output "[+] Shutdown Information"
            last -x -F shutdown >> "$output_file"
            ;;
        "uptime")
            update_output "[+] Uptime Information"
            echo '[*] The time a live system has been online for' >> "$output_file"
            uptime >> "$output_file"
            echo '[*] Show the uptime since when it was booted' >> "$output_file"
            uptime -s >> "$output_file"
            ;;
        "applications")
            update_output "[+] Check installed applications"
            echo '[*] Note: We will output all response in a text file' >> "$output_file"
            if ! command -v apt &> /dev/null; then
                dpkg -l >> "$output_file"
            else
                apt list --installed >> "$output_file"
            fi
            ;;
        "users")
            update_output "[+] Users and groups"
            echo '[*] Output Users on a text file' >> "$output_file"
            cat /etc/passwd >> "$output_file"
            echo '[*] Output Group on a text file' >> "$output_file"
            cat /etc/group >> "$output_file"
            ;;
        "crons")
            update_output "[+] Crons"
            echo '[*] Output Cron on a text file' >> "$output_file"
            cat /etc/crontab >> "$output_file"
            cat /var/spool/cron >> "$output_file"
            ;;
        "sudoers")
            update_output "[+] Sudoers"
            cat /etc/sudoers >> "$output_file"
            ;;
        "exit")
            echo "Exiting investigation script."
            break
            ;;
        *)
            echo "Invalid action. Please choose from: sysinfo, routing, shutdown, uptime, applications, users, crons, sudoers, exit."
            ;;
    esac
done
