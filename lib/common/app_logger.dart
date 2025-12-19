// ignore_for_file: deprecated_member_use
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// Log with using logger
final logger = Logger(
  filter: null, // Use the default LogFilter (-> only log in debug mode)
  printer: PrettyPrinter(
    methodCount: 2, // number of method calls to be displayed
    errorMethodCount: 5, // number of method calls if stacktrace is provided
    lineLength: 120, // width of the output (detect auto with io package io.stdout.terminalColumns)
    colors: true, // Colorful log messages (detect auto with io package io.stdout.supportsAnsiEscapes)
    printEmojis: true, // Print an emoji for each log message
    // printTime: false, // Should each log print contain a timestamp
    dateTimeFormat: DateTimeFormat.none, // Replace for printTime attribute that has been deprecated
    excludeBox: {
      // Level.all: true,
      // Level.trace: true,
      // Level.debug: true,
      // Level.info: true,
      // Level.warning: true,
      // Level.error: true,
      // Level.fatal: true,
      // Level.off: true,
    },
    noBoxingByDefault: true,
    levelColors: {},
    levelEmojis: {},
  ), // Use the PrettyPrinter to format and print log
  output: null, // Use the default LogOutput (-> send everything to console)
);

extension AppLoggerExtension on Level {
  String get message {
    switch (this) {
      case Level.verbose: // verbose is being deprecated in favor of trace instead.
      case Level.trace:
        return '🖇️ VERBOSE: ';
      case Level.debug:
        return '🐛 DEBUG: ';
      case Level.info:
        return 'ℹ️ INFO: ';
      case Level.warning:
        return '⚠️ WARNING: ';
      case Level.error:
        return '⛔ ERROR: ';
      case Level.wtf: // wtf is being deprecated in favor of fatal instead.
      case Level.fatal:
        return '💀 ERROR: ';
      case Level.nothing: // nothing is being deprecated in favor of off instead.
      case Level.off:
        return '';
      case Level.all:
        return '';
    }
  }
}

// There are 6 types of log: v, d, i, w, e, f
void log(dynamic message, {
  Level level = Level.trace,
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) => logger.log(level, '${level.message}$message', time: time, error: error, stackTrace: stackTrace);

// Default built in log for dart
void devLog(String mess) => dev.log('🦊 - $mess');

void printLog(String mess) {
  if(kDebugMode) {
    return print(mess);
  }
  return debugPrint(mess);
}

