import 'package:flutter_test/flutter_test.dart';

import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

void main() {
  PrettyFormatter formatter = PrettyFormatter();

  var result =
      formatter.format('message', StackTrace.current, LogLevel.warning);

  print(result);
}
