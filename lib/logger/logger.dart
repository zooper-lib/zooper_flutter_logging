import 'package:zooper_flutter_logging/formatter/log_formatter.dart';
import 'package:zooper_flutter_logging/logger/log_level.dart';
import 'package:zooper_flutter_logging/writer/log_writer.dart';

class Logger {
  final List<LogWriter> _logWriter;
  final LogFormatter? _logFormatter;

  Logger(this.minimumLoggingLevel, this._logWriter, [this._logFormatter]);

  LogLevel minimumLoggingLevel;

  /// Log any message
  Future logVerboseAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.verbose, stackTrace);

  /// Log a message only for debugging
  Future logDebugAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.debug, stackTrace);

  /// Log a info message
  Future logInfoAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.info, stackTrace);

  /// Log a warning
  Future logWarningAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.warning, stackTrace);

  /// Log an error
  Future logErrorAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.error, stackTrace);

  /// Logs a message when you don't know what is happening
  /// * WTFs are logged independently of the logging level
  Future logWtfAsync(String message, [StackTrace? stackTrace]) =>
      log(message, LogLevel.wtf, stackTrace);

  /// Log a message with it's StackTrace and level
  Future log(String message, LogLevel level, [StackTrace? stackTrace]) async {
    // If the level is less than the minimum level
    if (level.index < minimumLoggingLevel.index && level != LogLevel.wtf) {
      return Future.value();
    }

    if (_logFormatter != null) {
      message = _logFormatter!.format(message, StackTrace.current, level);
    }

    var futures = <Future>[];

    for (var logWriter in _logWriter) {
      var task = logWriter.writeAsync(message);
      futures.add(task);
    }

    return await Future.wait(futures);
  }
}
