#!/data/data/com.termux/files/usr/bin/bash

clear
echo ""
echo "==============================="
echo "   configfars | telegram"
echo "==============================="
echo ""
echo "1. Create config v2ray"
echo ""

read -p "Choose option: " option

option=$(echo "$option" | tr -d '[:space:]')

if [ "$option" = "1" ]; then

  CONFIG_URL="https://raw.githubusercontent.com/padarham9-ui/Create-config/main/config.txt"

  ID=$(settings get secure android_id 2>/dev/null)
  if [ -z "$ID" ]; then
    ID=$(getprop ro.serialno 2>/dev/null)
  fi

  if [ -z "$ID" ]; then
    echo ""
    echo "ERROR: Device ID not found!"
    exit 1
  fi

  SAVE_DIR="$HOME/.configfars"
  SAVE_FILE="$SAVE_DIR/used_$ID.txt"

  mkdir -p "$SAVE_DIR"

  if [ -f "$SAVE_FILE" ]; then
    echo ""
    echo "ERROR: You already received your config!"
    exit 1
  fi

  echo ""
  echo "Fetching config list..."

  CONFIG=$(curl -s "$CONFIG_URL" | grep -v '^$' | shuf -n 1)

  if [ -z "$CONFIG" ]; then
    echo ""
    echo "ERROR: Could not fetch config!"
    exit 1
  fi

  echo ""
  echo "==============================="
  echo "Your V2Ray Config:"
  echo "==============================="
  echo "$CONFIG"
  echo "==============================="

  echo "OK" > "$SAVE_FILE"

  echo ""
  echo "Done ✅"

else
  echo ""
  echo "Invalid option!"
  exit 1
fi
