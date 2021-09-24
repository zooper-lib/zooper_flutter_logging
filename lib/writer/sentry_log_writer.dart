import 'package:sentry/sentry.dart';
import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

class SentryLogWriter extends LogWriter {
  SentryLogWriter();

  static Future<SentryLogWriter> create(String dsn) async {
    var writer = SentryLogWriter();
    await Sentry.init((options) => {
          options.dsn = dsn,
        });

    return writer;
  }

  @override
  Future writeAsync(String message) async {
    await Sentry.captureMessage(message);
  }
}
