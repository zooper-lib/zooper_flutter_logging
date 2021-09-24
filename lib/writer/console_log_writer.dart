import 'package:flutter/foundation.dart';
import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

/// A simple class which writes the log into the console
class ConsoleLogWriter extends LogWriter {
  @override
  Future writeAsync(String message) {
    debugPrint(message);

    return Future.value();
  }
}
