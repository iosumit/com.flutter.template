@echo off
SET FLUTTER_TEMPLATE_REPO_URL=https://github.com/iosumit/com.flutter.template.git

:: Arguments
SET PROJECT_NAME=%1
SET ORG_NAME=%2
SET NEW_PROJECT_PATH=%3

:: Validate the project name (only lowercase letters allowed)
echo %PROJECT_NAME%| findstr /R "[^a-z]" >nul
IF %ERRORLEVEL% NEQ 1 (
    echo Error: Project name must contain only lowercase letters and no special characters or numbers.
    exit /b 1
)


IF "%PROJECT_NAME%"=="" (
    echo Usage: create_flutter_project.bat ^<project_name^>
    exit /b 1
)

:: Set default organization name if not provided
IF "%ORG_NAME%"=="" SET ORG_NAME=com

:: Navigate to the specified project directory
cd "%NEW_PROJECT_PATH%" || exit /b

:: Create the new Flutter project
echo Creating Flutter project: "%PROJECT_NAME%" with the bundle-id: "%ORG_NAME%.%PROJECT_NAME%"
powershell -Command "flutter create --org %ORG_NAME% %PROJECT_NAME%"

echo "Project Created"

IF %ERRORLEVEL% NEQ 0 (
    echo Failed to create the Flutter project. Exiting...
    exit /b 1
)
:: Navigate to the new project directory
IF "%NEW_PROJECT_PATH%"=="" (
    cd "%PROJECT_NAME%" || exit /b
) ELSE (
    cd "%NEW_PROJECT_PATH%/%PROJECT_NAME%" || exit /b
)

:: Clone the template repository into the new project directory
echo Cloning template files from GitHub...
git clone %FLUTTER_TEMPLATE_REPO_URL% .temp_template
:: Remove the template's .git directory to avoid conflicts with the new project
rmdir /s /q .temp_template\.git

mkdir assets
mkdir .vscode

:: Copy the template files into the new project directory, replacing the lib and assets directories
echo Copying template files into the new project...
xcopy /e /i /Y .temp_template\lib\* lib\
xcopy /e /i /Y .temp_template\assets\* assets\
xcopy /e /i /Y .temp_template\.vscode\* .vscode\
:: Copy individual files (l10n.yaml and gen)
echo f | xcopy /f .temp_template\l10n.yaml l10n.yaml /Y
echo f | xcopy /f .temp_template\gen gen /Y /E
echo f | xcopy /f .temp_template\gen.bat gen.bat /Y /E
:: Make the gen file executable 

:: Clean up the temporary cloned repository
rmdir /s /q .temp_template

:: Replace placeholder variables (like flutter_template) with the project name
echo Customizing files with project name "%PROJECT_NAME%"...
FOR /R %%f IN (*.dart *.yaml) DO (
    findstr /C:"flutter_template" "%%f" >nul
    IF %ERRORLEVEL% EQU 0 (
        powershell -Command "(Get-Content '%%f') -replace 'flutter_template', '%PROJECT_NAME%' | Set-Content '%%f'"
        echo Updated %%f
    )
)

:: Update pubspec.yaml file to add necessary configurations
SET PUBSPEC_FILE=pubspec.yaml
echo Updating pubspec.yaml...

findstr /C:"uses-material-design: true" %PUBSPEC_FILE% >nul
IF %ERRORLEVEL% EQU 0 (
    powershell -Command "$path = '%PUBSPEC_FILE%'; $content = [System.Collections.Generic.List[System.String]](Get-Content $path); $modified = $false; for ($i = 0; $i -lt $content.Count; $i++) { $line = $content[$i]; if ($line -match 'uses-material-design: true') { $content.Insert($i+1, '  generate: true'); $content.Insert($i+2, '  assets:'); $content.Insert($i+3, '    - assets/'); $content.Insert($i+4, '    - assets/images/'); $content.Insert($i+5, '    - assets/icons/'); $modified = $true } }; if ($modified) { $content | Set-Content $path } else { Write-Host 'No changes made to the file' }"
) ELSE (
    echo ^"flutter^": >> %PUBSPEC_FILE%
    echo ^  generate: true >> %PUBSPEC_FILE%
    echo ^  uses-material-design: true >> %PUBSPEC_FILE%
    echo. >> %PUBSPEC_FILE%
    echo ^  assets:^ >> %PUBSPEC_FILE%
    echo     - assets/ >> %PUBSPEC_FILE%
    echo     - assets/images/ >> %PUBSPEC_FILE%
    echo     - assets/icons/ >> %PUBSPEC_FILE%
)

:: Add necessary packages to pubspec.yaml
powershell -Command "flutter pub add flutter_localizations --sdk=flutter"
powershell -Command "flutter pub add intl:any"
powershell -Command "flutter pub add provider"
powershell -Command "flutter pub add shared_preferences"
powershell -Command "flutter pub add http"

:: Add generated files to .gitignore
echo /lib/generated/ >> .gitignore

:: Run gen 
gen

:: Final message
echo Flutter project "%PROJECT_NAME%" created, customized, and template files copied successfully!
