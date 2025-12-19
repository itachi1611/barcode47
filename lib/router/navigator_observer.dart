import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../common/app_logger.dart';

class NavObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(level: Level.info,'PUSH TO $route FROM $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(level: Level.info,'POP TO $route FROM $previousRoute');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log(level: Level.info,'REMOVE $route FROM $previousRoute');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log(level: Level.info,'REPLACE ROUTER $newRoute BY $oldRoute');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) => log(level: Level.info,'didStartUserGesture: $route, previousRoute= $previousRoute');

  @override
  void didStopUserGesture() => log(level: Level.info,'didStopUserGesture');
}