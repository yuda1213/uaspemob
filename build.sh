#!/bin/bash
# Build script for Netlify

# Exit on error
set -e

# Clone Flutter SDK
git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter-sdk
export PATH="$PATH:`pwd`/flutter-sdk/bin"

# Verify Flutter installation
flutter --version

# Get dependencies
flutter pub get

# Build for web
flutter build web --release

echo "Build completed successfully!"
