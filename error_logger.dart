import 'dart:io';
import 'package:logger/logger.dart';

class ErrorLogger {
  final Logger _logger = Logger();
  final File _logFile = File('${Directory.systemTemp.path}/neura_errors.log');

  void logError(Object error, StackTrace stack) {
    final msg = '${DateTime.now()}: $error\n$stack\n';
    _logger.e(msg);
    _logFile.writeAsStringSync(msg, mode: FileMode.append);
  }
}
