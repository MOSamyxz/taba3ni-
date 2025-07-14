import 'dart:developer' as dev;

class Logger {
  static void log(String message, {String name = 'APP'}) {
    dev.log(message, name: name);
  }

  static void error(String message, [Object? error, StackTrace? stack]) {
    dev.log('❌ $message', error: error, stackTrace: stack, name: 'ERROR');
  }
}
