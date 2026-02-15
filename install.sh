#!/data/data/com.termux/files/usr/bin/bash

clear
echo ""
echo "==============================="
echo "   configfars | telegram"
echo "==============================="
echo ""

CONFIG_URL="https://raw.githubusercontent.com/padarham9-ui/Create-config/main/config.txt"

ID=$(settings get secure android_id 2>/dev/null)
if [ -z "$ID" ]; then
  ID=$(getprop ro.serialno 2>/dev/null)
fi

if [ -z "$ID" ]; then
  echo "ERROR: Device ID not found!"
  exit 1
fi

SAVE_DIR="$HOME/.configfars"
SAVE_FILE="$SAVE_DIR/used_$ID.txt"

mkdir -p "$SAVE_DIR"

PS3=$'\nChoose option: '

select opt in "Create config v2ray" "Exit"
do
  case $REPLY in
    1)
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
      exit 0
      ;;
    2)
      echo ""
      echo "Bye 👋"
      exit 0
      ;;
    *)
      echo ""
      echo "Invalid option! Try again."
      ;;
  esac
done
