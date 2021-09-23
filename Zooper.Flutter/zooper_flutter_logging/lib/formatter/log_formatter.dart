import 'package:zooper_flutter_logging/logger/log_level.dart';

abstract class LogFormatter {
  String format(String message, StackTrace? stackTrace, LogLevel level);
}
