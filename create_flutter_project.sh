#!/bin/bash

#!/bin/bash

# Path to the template GitHub repository (URL)
FLUTTER_TEMPLATE_REPO_URL="https://github.com/iosumit/com.flutter.template.git"

# Name of the new project
NEW_PROJECT_PATH="$3"
PROJECT_NAME=$1
ORG_NAME=${2:-com}

# Validate the project name (only lowercase letters allowed)
if [[ ! "$PROJECT_NAME" =~ ^[a-z]+$ ]]; then
    echo "Error: Project name must contain only lowercase letters and no special characters or numbers."
    exit 1
fi

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: ./create_flutter_project.sh <project_name>"
    exit 1
fi

# Navigate to the specified project directory
cd "$NEW_PROJECT_PATH" || exit

# Create the new Flutter project
echo "Creating Flutter project '$PROJECT_NAME' with the organization 'com.$PROJECT_NAME'"
flutter create --org "$ORG_NAME" "$PROJECT_NAME"

if [ $? -ne 0 ]; then
    echo "Failed to create the Flutter project. Exiting..."
    exit 1
fi


# Navigate to the new project directory
if [ -z "$NEW_PROJECT_PATH" ]; then
    cd "$PROJECT_NAME" || exit
else
    cd "$NEW_PROJECT_PATH/$PROJECT_NAME" || exit
fi



# Clone the template repository into the new project directory
echo "Cloning template files from GitHub..."
git clone "$FLUTTER_TEMPLATE_REPO_URL" .temp_template

# Remove the template's .git directory to avoid conflicts with the new project
rm -rf .temp_template/.git

mkdir -p assets
mkdir -p .vscode
# Copy the template files into the new project directory, replacing the lib and assets directories
echo "Copying template files into the new project..."
cp -r .temp_template/lib/* "lib/"
cp -r .temp_template/assets/* "assets/"
cp -r .temp_template/.vscode/* ".vscode/"
cp -r .temp_template/l10n.yaml "l10n.yaml"
cp -r .temp_template/gen "gen"
chmod +x gen

# Clean up the temporary cloned repository
rm -rf .temp_template

# Replace placeholder variables (like flutter_template) with the project name
echo "Customizing files with project name '$PROJECT_NAME'..."
# Loop through each .dart and .yaml file in the current directory
for file in $(find . -type f \( -name "*.dart" -o -name "*.yaml" \)); do
    # Check if flutter_template exists in the file
    if grep -q "flutter_template" "$file"; then
        # If found, replace flutter_template with PROJECT_NAME
        sed -i '' "s/flutter_template/$PROJECT_NAME/g" "$file"
        echo "Updated $file"
    fi
done

# Update pubspec.yaml file to add necessary configurations
PUBSPEC_FILE="pubspec.yaml"
echo "Updating pubspec.yaml..."

if grep -q "^flutter:" "$PUBSPEC_FILE"; then
    # Append under the `flutter:` block
    sed -i '' '/^flutter:/a\
  generate: true\
  assets:\
    - assets/\
    - assets/images/\
    - assets/icons/' "$PUBSPEC_FILE"
else
    echo "
flutter:
  generate: true
  uses-material-design: true

  assets:
    - assets/
    - assets/images/
    - assets/icons/
" >> "$PUBSPEC_FILE"
fi


flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
flutter pub add provider
flutter pub add shared_preferences
flutter pub add http

echo "
/lib/generated/
" >> .gitignore

./gen

# Final message
echo "Flutter project '$PROJECT_NAME' created, customized, and template files copied successfully!"

