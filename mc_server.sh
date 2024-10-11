#!/bin/bash

session_name=mc_server

# Function to start a new screen session
start_screen() {
    screen -dmS "$session_name" bash -c "/usr/local/openjdk21/bin/java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui; exec bash"
    if [ $? -eq 0 ]; then
        echo "Minecraft server started"
    else
        echo "Failed to start the server"
    fi
}

# Function to stop a running screen session
stop_screen() {
    screen -ls | grep "$session_name" > /dev/null
    if [ $? -eq 0 ]; then
        screen -S "$session_name" -X quit
        echo "Minecraft server has been stopped."
    else
        echo "Error"
    fi
}

# Function to enter an existing screen session
enter_screen() {
    screen -ls | grep "$session_name" > /dev/null
    if [ $? -eq 0 ]; then
        screen -r "$session_name"
    else
        echo "Found no minecraft server"
    fi
}

# Ask the user whether to start, stop, or enter a screen session
echo "What would you like to do?"
echo "1) Start the minecraft server"
echo "2) Stop the minecraft server"
echo "3) Enter the minecraft server"
read -p "Enter your choice (1/2/3): " choice

# Execute the appropriate function based on the user's choice
case "$choice" in
    1)
        start_screen
        ;;
    2)
        stop_screen
        ;;
    3)
        enter_screen
        ;;
    *)
        echo "Invalid choice. Please enter 1 to start, 2 to stop, or 3 to enter a screen session."
        ;;
esac
