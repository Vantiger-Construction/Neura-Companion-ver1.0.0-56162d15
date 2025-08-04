
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

class CrashLogger {
  static void logError(dynamic error, StackTrace stack, {String? context}) {
    dev.log('Error caught: \$error', name: 'NeuraCrashLogger');
    dev.log('Stack: \$stack', name: 'NeuraCrashLogger');
    if (context != null) {
      dev.log('Context: \$context', name: 'NeuraCrashLogger');
    }

    if (kReleaseMode) {
      // Uncomment when Sentry is integrated
      // Sentry.captureException(error, stackTrace: stack);
    }
  }

  static Future<void> guarded(Function runApp) async {
    try {
      runApp();
    } catch (e, stack) {
      logError(e, stack, context: "Guarded Run Error");
    }
  }
}
