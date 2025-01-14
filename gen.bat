powershell -Command "flutter gen-l10n"
powershell -Command "flutter pub get"
dart lib/post_build.dart
