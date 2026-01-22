#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Flutter Web Build on Vercel..."

# Define Flutter settings
FLUTTER_CHANNEL="stable"
FLUTTER_VERSION="3.27.1" # Using a recent stable version compatible with our changes

# Download and install Flutter if not cached
if [ ! -d "flutter" ]; then
  echo "Downloading Flutter..."
  git clone https://github.com/flutter/flutter.git -b $FLUTTER_CHANNEL
fi

# Add flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Detailed version info
flutter --version

echo "Enabling shared_preferences for web..."
# Sometimes needed for web builds depending on plugins
flutter config --enable-web

# Navigate to the project directory
# IMPORTANT: Updated path matching where the flutter project is
cd frontend/appflowy_flutter

echo "Getting dependencies..."
flutter pub get

echo "Building Web Release..."
# --base-href / ensures it works on root domains. If subdirectory, adjust.
flutter build web --release --no-tree-shake-icons

echo "Build complete!"
