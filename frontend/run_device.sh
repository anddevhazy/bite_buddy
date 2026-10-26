#!/bin/sh
# Runs the app on a plugged-in phone, pointed at the Serverpod server on this
# Mac. Start the server first: cd backend/bite_buddy_server && serverpod start
# The phone and the Mac must be on the same Wi-Fi.
# Extra arguments go to `flutter run`, e.g. ./run_device.sh -d <device-id>
set -e
cd "$(dirname "$0")"

IP=$(ipconfig getifaddr en0 || ipconfig getifaddr en1 || true)
if [ -z "$IP" ]; then
  echo "Couldn't find this Mac's Wi-Fi IP. Is Wi-Fi on?" >&2
  exit 1
fi

echo "Server URL: http://$IP:8080/"
exec fvm flutter run --dart-define=SERVER_URL="http://$IP:8080/" "$@"
