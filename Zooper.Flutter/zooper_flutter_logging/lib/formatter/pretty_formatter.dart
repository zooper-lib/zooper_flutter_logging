import 'package:zooper_flutter_logging/formatter/log_formatter.dart';
import 'package:zooper_flutter_logging/logger/log_level.dart';

class PrettyFormatter extends LogFormatter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';

  static const newLine = '\n';

  static final levelEmojis = {
    LogLevel.verbose: '',
    LogLevel.debug: '🐛',
    LogLevel.info: '💡',
    LogLevel.warning: '⚠️',
    LogLevel.error: '⛔',
    LogLevel.wtf: '👾',
  };

  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  /// Matches a stacktrace line as generated by browser Dart.
  /// For example:
  /// dart:sdk_internal
  /// package:logger/src/logger.dart
  static final _browserStackTraceRegex =
      RegExp(r'^(?:package:)?(dart:[^\s]+|[^\s]+)');

  /// The index which to begin the stack trace at
  ///
  /// This can be useful if, for instance, Logger is wrapped in another class and
  /// you wish to remove these wrapped calls from stack trace
  final int stackTraceBeginIndex;
  final int errorMethodCount;
  final int lineLength;
  final bool colors;
  final bool printEmojis;

  /// To prevent ascii 'boxing' of any log [Level] include the level in map for excludeBox,
  /// for example to prevent boxing of [Level.verbose] and [Level.info] use excludeBox:{Level.verbose:true, Level.info:true}
  final Map<LogLevel, bool> excludeBox;

  /// To make the default for every level to prevent boxing entirely set [noBoxingByDefault] to true
  /// (boxing can still be turned on for some levels by using something like excludeBox:{Level.error:false} )
  final bool noBoxingByDefault;

  late String _topBorder;
  late String _middleBorder;
  late String _bottomBorder;

  PrettyFormatter({
    this.stackTraceBeginIndex = 0,
    this.errorMethodCount = 8,
    this.lineLength = 120,
    this.colors = true,
    this.printEmojis = true,
    this.excludeBox = const {},
    this.noBoxingByDefault = false,
  }) {
    var doubleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
    _middleBorder = '$middleCorner$doubleDividerLine';
    _bottomBorder = '$bottomLeftCorner$doubleDividerLine';
  }

  @override
  String format(String message, StackTrace? stackTrace, LogLevel level) {
    String stackTraceStr = stackTrace == null
        ? _formatStackTrace(StackTrace.current)
        : _formatStackTrace(stackTrace);

    return _format(
      level,
      message,
      _getTime(),
      stackTraceStr,
    );
  }

  String _getTime() {
    String _threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    return '$h:$min:$sec.$ms';
  }

  String _formatStackTrace(StackTrace stackTrace) {
    var lines = stackTrace.toString().split(newLine);
    if (stackTraceBeginIndex > 0 && stackTraceBeginIndex < lines.length - 1) {
      lines = lines.sublist(stackTraceBeginIndex);
    }
    var formatted = <String>[];
    var count = 0;
    for (var line in lines) {
      if (_discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line) ||
          _discardBrowserStacktraceLine(line) ||
          line.isEmpty) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
    }

    if (formatted.isEmpty) {
      return '';
    } else {
      return formatted.join(newLine);
    }
  }

  bool _discardDeviceStacktraceLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)!.startsWith('package:zooper_flutter_logging');
  }

  bool _discardWebStacktraceLine(String line) {
    var match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('packages/zooper_flutter_logging') ||
        match.group(1)!.startsWith('dart-sdk/lib');
  }

  bool _discardBrowserStacktraceLine(String line) {
    var match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('package:zooper_flutter_logging') ||
        match.group(1)!.startsWith('dart:');
  }

  String _format(
    LogLevel level,
    String message,
    String? time,
    String? stacktrace,
  ) {
    List<String> buffer = [];

    buffer.add(_topBorder);

    // The time
    if (time != null) {
      buffer.add('$verticalLine $time');
      buffer.add(_middleBorder);
    }

    // The message
    var emoji = _getEmoji(level);
    for (var line in message.split(newLine)) {
      buffer.add('$verticalLine $emoji $line');
    }
    buffer.add(_middleBorder);

    // The StackTrace
    if (stacktrace != null) {
      for (var line in stacktrace.split(newLine)) {
        buffer.add('$verticalLine $line');
      }
    }
    buffer.add(_bottomBorder);

    return buffer.join(newLine);
  }

  String _getEmoji(LogLevel level) {
    if (printEmojis) {
      return levelEmojis[level]!;
    } else {
      return '';
    }
  }
}