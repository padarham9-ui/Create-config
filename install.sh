#!/data/data/com.termux/files/usr/bin/bash

exec < /dev/tty

clear
echo ""
echo "==============================="
echo "   configfars | telegram"
echo "==============================="
echo ""

CONFIG_URL="https://raw.githubusercontent.com/padarham9-ui/Create-config/main/config.txt"

BASE_DIR="/data/data/com.termux/files/home/.configfars"
LOCK_FILE="$BASE_DIR/used.txt"

mkdir -p "$BASE_DIR"

pkg install -y curl coreutils > /dev/null 2>&1

echo "1. Create config v2ray"
echo "2. Exit"
echo ""
read -p "Choose option: " option

option=$(echo "$option" | tr -d '[:space:]')

if [ "$option" = "1" ]; then

  if [ -f "$LOCK_FILE" ]; then
    echo ""
    echo "ERROR: You already received your config!"
    exit 1
  fi

  echo ""
  echo "Fetching config list..."
  echo ""

  DATA=$(curl -sL "$CONFIG_URL")

  if [ -z "$DATA" ]; then
    echo "ERROR: Failed to download config.txt"
    exit 1
  fi

  CONFIG=$(echo "$DATA" | grep -v '^$' | shuf -n 1)

  if [ -z "$CONFIG" ]; then
    echo "ERROR: config.txt is empty!"
    exit 1
  fi

  echo ""
  echo "==============================="
  echo "Your V2Ray Config:"
  echo "==============================="
  echo "$CONFIG"
  echo "==============================="

  echo "USED" > "$LOCK_FILE"

  echo ""
  echo "Done ✅"
  exit 0

elif [ "$option" = "2" ]; then
  echo ""
  echo "Bye 👋"
  exit 0
else
  echo ""
  echo "Invalid option!"
  exit 1
fi
