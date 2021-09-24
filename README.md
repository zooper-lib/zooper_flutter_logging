This library provides a wrapper for loggers. Some examples are included.
Note: This library is part of the whole zooper lib family. 
For more information see: https://pub.dev/packages/zooper_flutter_core

## Getting started

Add a new line inside your `pubspec.yaml`:

`zooper_flutter_logging: <latest>`

## Usage

To use the logger you have to instantiate at least 2 classes:

### The log writer

The logger needs a writer it can write the log to. This can be the console,
an api or a file. You can also define multiple writer which the logger writes to simultanously.

``` dart
import 'package:flutter/foundation.dart';
import 'package:zooper_flutter_logging/zooper_flutter_logging.dart';

class ConsoleLogWriter extends LogWriter {
  @override
  Future writeAsync(String message) {
    debugPrint(message);

    return Future.value();
  }
}
```

This is an example of a console writer which also can be found inside this package.

``` dart
var writer = ConsoleLogWriter();
```

### The logger

After that, you need to pass the writer to the logger:

``` dart
var logger = Logger(minimumLoggingLevel, _logWriter);
```

The `minimumLoggingLevel` defines what type of log should be logged. These options are available (starting from the lowest to the highest):

``` dart
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
}
```

The `_logWriter` expects a list of writers like our `ConsoleWriter`.

After all is set up, you can log messages like so:

```dart 
logger.logInfoAsync('Your message');
```

or with `StackTrace`

```dart 
logger.logInfoAsync('Your message', StackTrace.current);
```

or

``` dart
logger.log('Your message', LogLevel.info, StackTrace.current);
```

### Formatting the output

Use the `LogFormatter` base class to dress up the output. An example class is also included named `PrettyFormatter`.

``` dart
var formatter = PrettyFormatter();
```

Then you can pass it to our logger:

``` dart
var logger = Logger(<minimumLoggingLevel>, <_logWriter>, formatter);
```