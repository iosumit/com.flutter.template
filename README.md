# Flutter Quick Start Template

This template simplifies the process of creating a Flutter project by providing a single script file that sets up the project with pre-configured features like:

- **Authentications Screen**
- **App Localization**
- **MatrialApp Routings**
- **Theming**
- Adding necessary **dependencies**

## Features
- **Quick Setup:** Automatically generate a Flutter project with essential files and configurations.
- **Customizable:** Modify the generated files as per your requirements.
- **Time-Saving:** Skip repetitive setup tasks and focus on building your app.

---

## Getting Started
- Prerequisite Softwares that need to be installed
  - [Flutter](https://flutter.dev/)
  - [Git](https://git-scm.com/)
- [For Windows](#for-windows)
- [For Mac or Linux](#for-mac-or-linux)
---
### For Windows
#### 1. Download the Script File
Download the script file from this repository:
```bash
curl -O https://raw.githubusercontent.com/iosumit/com.flutter.template/refs/heads/main/create_flutter_project.bat
```
### 2. Run the Script
Run the downloaded script in your command prompt to create a new Flutter project:
```bash
create_flutter_project #<project-name> #<organization-name>
```
---

### For Mac or linux


### 1. Download the Script File
Download the script file from this repository:
```bash
curl -O https://raw.githubusercontent.com/iosumit/com.flutter.template/refs/heads/main/create_flutter_project.sh
```
### 2. Give the execute permissions
```bash
chmod +x create_flutter_project.sh
```

### 3. Run the Script
Run the downloaded script in your terminal to create a new Flutter project:
```bash
./create_flutter_project.sh #<project-name> #<organization-name>
```
---
The script will:
- Create a new Flutter project
- Add pre-configured files 
- Set up app theming
- Add necessary dependencies to `pubspec.yaml`

Run Project
--
All commands are same as flutter, this reporitory just creating template
```
flutter run
```
just one more command added

#### *** Everytime once you write or modify your `.arb` file always run in terminal below command. it will automatically generate different variation of Langs.dart depending on supported languages ***
### For Windows run
``` bash
gen
# or 
gen.bat
```
### For Mac / Linux run
```
./gen
```
#### if above command requires execute permissions then 1st run below one and then above
```
chmod +x 
```


## What's Included
The script adds the following files to your project:

### 1. Pre-configured Directory Structure
- **`lib/`**: Core Flutter files, including:
  - `/auth/loginscreen.dart`: A sample authentications screens for quick onboarding.
  - Localization setup for multi-language support.
  - Theming files for light and dark modes.
- **`assets/`**: Placeholder directories for:
  - **Images**: `assets/images/`
  - **Icons**: `assets/icons/`
- **`.vscode/`**: Pre-configured settings for efficient Flutter development.
### 2.  `Pages`
- `lib/pages/splash_page.dart`
- `lib/pages/auth/login_page.dart`
- `lib/pages/auth/onboarding_page.dart`
- `lib/pages/auth/signup_page.dart`
- `lib/pages/auth/reset_page.dart`

A fully functional Authentication screens.

### 3. `Localization`
- `lib/l10n/app_en.arb`
- `lib/l10n/app_hi.arb`

Localization setup to support multiple languages.
### 4. `lib/utils/themes.dart`
Customizable theming configuration.
### 5. `colors.dart`
Customizable color configuration.
### 6. Updated `pubspec.yaml`
Dependencies for Flutter localization, theming, and more.

---

## Dependencies
The script adds the following dependencies to your project:
- `flutter_localizations`
- `provider`
- `shared_preferences`
- `flutter_localizations:`
    - `sdk: flutter`
- `intl: any`
- `provider`
- `shared_preferences`
- `http`
- And others necessary for the template setup.

---

## Customization
After running the script, you can:
1. Edit the `Authentication screens` and `auth_controller` to fit your design.
2. Add more languages in the `l10n` directory.
3. Modify the `theme.dart` file to customize the app's appearance.

---
## Some codes 
```dart
// for toggling the themes
Provider.of<ThemeProvider>(context, listen: false).toggleTheme();

// for getting localization variables use
Langs.of(context)!.name
```

---

## Contributing
Contributions are welcome! Feel free to fork this repository, make your changes, and submit a pull request.

---

## License
This project is licensed under the [MIT License](LICENSE).

---

## Support
If you encounter any issues or have questions, please open an issue in this repository.

Happy coding! 🚀