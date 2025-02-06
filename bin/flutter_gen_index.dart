import 'dart:io';

import 'package:flutter_gen_index/log_untls.dart';

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    if (arguments[0] == 'flutter_gen_index' || arguments[0] == 'gen_index') {
      startExecutingCommands();
    } else {
      logError('Invalid command. Use "flutter_gen_index" or "gen_index".');
      exit(1);
    }
  } else {
    logError('Invalid command. Use "flutter_gen_index" or "gen_index".');
    exit(1);
  }
}

void startExecutingCommands() {
  final directory = Directory.current; // 获取当前目录
  logInfo('Scanning directory: ${directory.path}');

  final dartFiles = getDartFiles(directory);
  final totalFiles = dartFiles.length;

  if (totalFiles == 0) {
    logError('No .dart files found.');
    return;
  }

  generateIndexFile(dartFiles);
  logSuccess('✅ index.dart generated successfully with $totalFiles files.');
}

List<File> getDartFiles(Directory directory) {
  return directory
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !file.path.endsWith('index.dart')) // 排除 index.dart
      .toList();
}

void generateIndexFile(List<File> dartFiles) {
  final indexFile = File('${Directory.current.path}/index.dart');
  final buffer = StringBuffer();

  buffer.writeln('// Auto-generated index file');
  buffer.writeln('// Exporting ${dartFiles.length} files');
  buffer.writeln('');

  for (var file in dartFiles) {
    final relativePath = file.path.replaceFirst('${Directory.current.path}/', '');
    buffer.writeln("export '$relativePath';");
  }

  indexFile.writeAsStringSync(buffer.toString());
}
