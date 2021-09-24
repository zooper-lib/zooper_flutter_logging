//import 'package:flutter_test/flutter_test.dart';
import 'package:zooper_flutter_logging/writer/console_log_writer.dart';

import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

// ! These are no real tests
void main() {
  PrettyFormatter formatter = PrettyFormatter();
  var writer = ConsoleLogWriter();

  var logger = Logger(LogLevel.info, [writer], formatter);

  logger.logInfoAsync('Your message');
  logger.log('Your message', LogLevel.info, StackTrace.current);
}
