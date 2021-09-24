import 'package:sentry/sentry.dart';
import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

/// A wrapper class which writes the log to [Sentry]
///
/// see: https://sentry.io/
class SentryLogWriter extends LogWriter {
  static Future<SentryLogWriter> create(String dsn) async {
    var writer = SentryLogWriter();
    await Sentry.init((options) => {
          options.dsn = dsn,
        });

    return writer;
  }

  @override
  Future writeAsync(String message) {
    return Sentry.captureMessage(message);
  }
}
