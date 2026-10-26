#!/bin/sh
# Starts the database and the server (`serverpod start`) with this project's
# Flutter/Dart (3.47.7 via FVM), not the global install. Run the app on a
# phone separately with frontend/run_device.sh.
set -e
cd "$(dirname "$0")"

SDK="$HOME/fvm/versions/3.47.7/bin"
if [ ! -x "$SDK/dart" ]; then
  echo "Flutter 3.47.7 isn't installed. Run: fvm install 3.47.7" >&2
  exit 1
fi

export PATH="$SDK:$HOME/.pub-cache/bin:$PATH"
exec serverpod start "$@"
