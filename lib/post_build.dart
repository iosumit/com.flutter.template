import 'dart:io';

void main() {
  final sourceDir = Directory('.dart_tool/flutter_gen/gen_l10n');
  final destinationDir = Directory('lib/generated/gen_l10n');

  // Check if the source directory exists
  if (sourceDir.existsSync()) {
    // Create destination directory if it doesn't exist
    destinationDir.createSync(recursive: true);

    // List all files in the source directory
    final files = sourceDir.listSync();

    // Move each file to the destination directory
    for (var file in files) {
      if (file is File) {
        final destinationPath =
            '${destinationDir.path}/${file.uri.pathSegments.last}';
        final destinationFile = File(destinationPath);

        file.copySync(destinationFile.path);
        print('Moved ${file.uri.pathSegments.last} to $destinationPath');
      }
    }
  } else {
    print('Source directory not found!');
  }
}
