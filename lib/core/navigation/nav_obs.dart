import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/logger.dart';
import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:flutter/material.dart';

import 'nav.dart';

class NavObs extends RouteObserver<PageRoute<dynamic>> {
  final List<Route> routeStack = [];

  _onChanged() {
    // final currentPage = current;
    // if (currentPage != null) {
    // SystemColors.setStyleForPage(currentPage);
    // }
    logger('NAV', {
      'routeStack': routeStack.map((e) => e.settings.name).toList(),
      'current': current?.name,
    });
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    routeStack.add(route);
    _onChanged();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    routeStack.remove(route);
    _onChanged();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    routeStack.remove(route);
    _onChanged();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    final index = routeStack.indexOf(oldRoute!);
    if (index != -1) {
      routeStack[index] = newRoute!;
    } else {
      routeStack.add(newRoute!);
    }
    _onChanged();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  bool containsRoute(Nav routeName) => routeStack.any((route) => route.settings.name == routeName.name);

  bool isLast(Nav routeName) => routeStack.safeLast?.settings.name == routeName.name;

  Nav? get current => validateEnumNullable(Nav.values, routeStack.safeLast?.settings.name);
}
