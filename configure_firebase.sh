#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage
display_usage() {
    echo "Usage: $0 --project=<project-name> \
               --ios-bundle-id=<ios-bundle-id> \
               --android-package-name=<android-package-name> \
               --env=<environment>"
}

# Parse arguments
for ARGUMENT in "$@"
do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2- -d=)
    
    case "$KEY" in
        --project) PROJECT="$VALUE" ;;
        --ios-bundle-id) IOS_BUNDLE_ID="$VALUE" ;;
        --android-package-name) ANDROID_PACKAGE_NAME="$VALUE" ;;
        --env) ENV="$VALUE" ;;
        *)
    esac    

done

# Check if all required arguments are provided
if [ -z "$PROJECT" ] || [ -z "$IOS_BUNDLE_ID" ] || [ -z "$ANDROID_PACKAGE_NAME" ] || [ -z "$ENV" ]; then
    echo "Error: Missing required arguments."
    display_usage
    exit 1
fi

# Run flutterfire config
flutterfire config \
    --project="$PROJECT" \
    --ios-bundle-id="$IOS_BUNDLE_ID" \
    --android-package-name="$ANDROID_PACKAGE_NAME"

# Define target directory
target_dir="environments/$ENV"

# Ensure the target directory exists
mkdir -p "$target_dir"

# Move generated files to the environment directory
mv lib/firebase_options.dart "$target_dir/"
mv ios/Runner/GoogleService-Info.plist "$target_dir/"
mv android/app/google-services.json "$target_dir/"
mv firebase.json "$target_dir/"

# Success message
echo "Files moved to $target_dir successfully."
