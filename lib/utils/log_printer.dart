import 'dart:convert';

import 'package:logger/logger.dart';

class CPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  static final levelColors = {
    Level.trace: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: const AnsiColor.none(),
    Level.info: const AnsiColor.fg(12),
    Level.warning: const AnsiColor.fg(208),
    Level.error: const AnsiColor.fg(196),
    Level.fatal: const AnsiColor.fg(199),
  };

  static final levelEmojis = {
    Level.trace: '',
    Level.debug: '🐛 ',
    Level.info: '💡 ',
    Level.warning: '⚠️ ',
    Level.error: '⛔ ',
    Level.fatal: '👾 ',
  };

  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\s+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex = RegExp(r'^((packages|dart-sdk)/\S+/)');

  static late DateTime _startTime;

  late final int offsetMethodCount;
  late final int methodCount;
  final int? errorMethodCount;
  late final int lineLength;
  final bool? colors;
  late final bool printEmojis;
  late final bool printTime;

  int? dynamicMethodCount;
  String? _topBorder = '';
  String _middleBorder = '';
  String? _bottomBorder = '';
  String? tag;

  CPrinter({
    this.offsetMethodCount = 2,
    this.methodCount = 2,
    this.errorMethodCount = 8,
    this.lineLength = 120,
    this.colors = true,
    this.printEmojis = true,
    this.printTime = false,
  }) {
    _startTime = DateTime.now();

    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
    _middleBorder = '$middleCorner$singleDividerLine';
    _bottomBorder = '$bottomLeftCorner$doubleDividerLine';
  }

  void setTag(String? tag) {
    tag = '';
    this.tag = tag;
  }

  void setDynamicMethodCount(int? dynamicMethodCount) {
    this.dynamicMethodCount = dynamicMethodCount;
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.stackTrace == null) {
      final int methodCount = dynamicMethodCount ?? this.methodCount;
      dynamicMethodCount = null;
      if (methodCount > 0) {
        stackTraceStr = formatStackTrace(
            StackTrace.current, methodCount, offsetMethodCount);
      }
    } else {
      stackTraceStr = formatStackTrace(event.stackTrace, -1, 0);
    }

    var errorStr = event.error?.toString();

    String? timeStr;
    if (printTime) {
      timeStr = getTime();
    }

    return _formatAndPrint(
      event.level,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

  String? formatStackTrace(
      StackTrace? stackTrace, int methodCount, int offset) {
    var lines = stackTrace.toString().split('\n');
    var formatted = <String>[];
    var count = 0;
    var curOffset = 0;
    for (var line in lines) {
      if (_discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line)) {
        continue;
      }
      if (curOffset < offset) {
        curOffset++;
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
      if (methodCount > 0 && ++count == methodCount) {
        break;
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  bool _discardDeviceStacktraceLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)?.startsWith('package:logger') == true;
  }

  bool _discardWebStacktraceLine(String line) {
    var match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)?.startsWith('packages/logger') == true ||
        match.group(1)?.startsWith('dart-sdk/lib') == true;
  }

  String _threeDigits(int n) {
    if (n >= 100) return '$n';
    if (n >= 10) return '0$n';
    return '00$n';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String getTime() {
    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    var timeSinceStart = now.difference(_startTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart)';
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = const JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  AnsiColor _getLevelColor(Level level) {
    if (colors == true) {
      return levelColors[level] ?? const AnsiColor.none();
    } else {
      return const AnsiColor.none();
    }
  }

  AnsiColor _getErrorColor(Level level) {
    if (colors == true) {
      if (level == Level.fatal) {
        return levelColors[Level.fatal]?.toBg() ?? const AnsiColor.none();
      } else {
        return levelColors[Level.error]?.toBg() ?? const AnsiColor.none();
      }
    } else {
      return const AnsiColor.none();
    }
  }

  String _getEmoji(Level level) {
    if (printEmojis) {
      return levelEmojis[level] ?? '';
    } else {
      return '';
    }
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String? time,
    String? error,
    String? stacktrace,
  ) {
    // This code is non trivial and a type annotation here helps understanding.
    // ignore: omit_local_variable_types
    List<String> buffer = [];
    var color = _getLevelColor(level);
    buffer.add(color('${tag ?? ""}$_topBorder'));

    if (error != null) {
      var errorColor = _getErrorColor(level);
      for (var line in error.split('\n')) {
        buffer.add(
          color('${tag ?? ""}$verticalLine ') +
              errorColor.resetForeground +
              errorColor(line) +
              errorColor.resetBackground,
        );
      }
      buffer.add(color('${tag ?? ""}$_middleBorder'));
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        buffer.add('${tag ?? ""}$color$verticalLine $line');
      }
      buffer.add(color('${tag ?? ""}$_middleBorder'));
    }

    if (time != null) {
      buffer
        ..add(color('${tag ?? ""}$verticalLine $time'))
        ..add(color(_middleBorder));
    }

    var emoji = _getEmoji(level);
    for (var line in message.split('\n')) {
      buffer.add(color('${tag ?? ""}$verticalLine $emoji$line'));
    }
    buffer.add(color('${tag ?? ""}$_bottomBorder'));
    tag = null;
    return buffer;
  }
}