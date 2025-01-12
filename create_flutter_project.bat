@echo off

REM Path to the template GitHub repository (URL)
SET FLUTTER_TEMPLATE_REPO_URL=https://github.com/iosumit/com.flutter.template.git

REM Arguments
SET PROJECT_NAME=%1
SET ORG_NAME=%2
SET NEW_PROJECT_PATH=%3

REM Set default organization name if not provided
IF "%ORG_NAME%"=="" (
    SET ORG_NAME=com
)

REM Validate the project name (only lowercase letters allowed)
FOR /F "delims=abcdefghijklmnopqrstuvwxyz" %%C IN ("%PROJECT_NAME%") DO (
    ECHO Error: Project name must contain only lowercase letters and no special characters or numbers.
    EXIT /B 1
)

IF "%PROJECT_NAME%"=="" (
    ECHO Usage: create_flutter_project.bat <project_name> [organization_name] <new_project_path>
    EXIT /B 1
)

REM Navigate to the specified project directory
PUSHD "%NEW_PROJECT_PATH%" || EXIT /B 1

REM Create the new Flutter project
ECHO Creating Flutter project "%PROJECT_NAME%" with the organization "com.%PROJECT_NAME%"
flutter create --org "%ORG_NAME%" "%PROJECT_NAME%"
IF ERRORLEVEL 1 (
    ECHO Failed to create the Flutter project. Exiting...
    EXIT /B 1
)

REM Navigate to the new project directory
IF "%NEW_PROJECT_PATH%"=="" (
    PUSHD "%PROJECT_NAME%"
) ELSE (
    PUSHD "%NEW_PROJECT_PATH%\%PROJECT_NAME%"
)

REM Clone the template repository into the new project directory
ECHO Cloning template files from GitHub...
git clone "%FLUTTER_TEMPLATE_REPO_URL%" .temp_template

REM Remove the template's .git directory to avoid conflicts with the new project
RMDIR /S /Q .temp_template\.git

REM Ensure required directories exist
MKDIR assets
MKDIR .vscode

REM Copy the template files into the new project directory
ECHO Copying template files into the new project...
XCOPY /E /I /Q .temp_template\lib lib
XCOPY /E /I /Q .temp_template\assets assets
XCOPY /E /I /Q .temp_template\.vscode .vscode
COPY /Y .temp_template\l10n.yaml l10n.yaml
XCOPY /E /I /Q .temp_template\gen gen
attrib +x gen

REM Clean up the temporary cloned repository
RMDIR /S /Q .temp_template

REM Replace placeholder variables (like flutter_template) with the project name
ECHO Customizing files with project name "%PROJECT_NAME%"...
FOR /R %%F IN (*.dart *.yaml) DO (
    FINDSTR /I "flutter_template" "%%F" >NUL
    IF ERRORLEVEL 0 (
        powershell -Command "(Get-Content -Path '%%F') -replace 'flutter_template', '%PROJECT_NAME%' | Set-Content -Path '%%F'"
        ECHO Updated %%F
    )
)

REM Update pubspec.yaml file to add necessary configurations
SET PUBSPEC_FILE=pubspec.yaml
ECHO Updating pubspec.yaml...

FINDSTR /B /C:"flutter:" "%PUBSPEC_FILE%" >NUL
IF ERRORLEVEL 1 (
    ECHO flutter:
    ECHO   generate: true
    ECHO   uses-material-design: true
    ECHO
    ECHO   assets:
    ECHO     - assets/
    ECHO     - assets/images/
    ECHO     - assets/icons/
) >> "%PUBSPEC_FILE%"
) ELSE (
    powershell -Command "(Get-Content -Path '%PUBSPEC_FILE%') -replace '^flutter:', 'flutter:`r`n  generate: true`r`n  assets:`r`n    - assets/`r`n    - assets/images/`r`n    - assets/icons/' | Set-Content -Path '%PUBSPEC_FILE%'"
)

REM Add dependencies
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl:any
flutter pub add provider
flutter pub add shared_preferences
flutter pub add http

REM Run the generator script
CALL gen

REM Final message
ECHO Flutter project "%PROJECT_NAME%" created, customized, and template files copied successfully!

REM Return to the original directory
POPD
