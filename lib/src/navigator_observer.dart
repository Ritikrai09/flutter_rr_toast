import 'package:flutter/material.dart';

class RRNavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPush;
  void Function(Route<dynamic>? newRoute, Route<dynamic>? oldRoute)? didReplace;
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didRemove;
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? didPop;

  RRNavigatorObserverProxy(
      {this.didPush, this.didReplace, this.didRemove, this.didPop});

  RRNavigatorObserverProxy.all(VoidCallback leavePageCallback) {
    didPush = (_, __) => leavePageCallback();
    didReplace = (_, __) => leavePageCallback();
    didRemove = (_, __) => leavePageCallback();
    didPop = (_, __) => leavePageCallback();
  }
}

///[Navigator.observers]
class RRNavigatorObserver extends NavigatorObserver {
  static final List<RRNavigatorObserverProxy> _leavePageCallbacks = [];

  static bool debugInitialization = false;

  RRNavigatorObserver() {
    assert(() {
      debugInitialization = true;
      return true;
    }());
  }

  static void register(
      RRNavigatorObserverProxy rrNavigatorObserverProxy) {
    assert(debugInitialization, """
    Please initialize!
    Example:
    BotToastInit(
      child:MaterialApp(
      title: 'Xxxx Demo',
      navigatorObservers: [RRNavigatorObserver()],
      home: XxxxPage(),
    ));
    """);
    _leavePageCallbacks.add(rrNavigatorObserverProxy);
  }

  static void unregister(
      RRNavigatorObserverProxy rrNavigatorObserverProxy) {
    _leavePageCallbacks.remove(rrNavigatorObserverProxy);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (RRNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPush?.call(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (RRNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didReplace?.call(newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (RRNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didRemove?.call(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (RRNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPop?.call(route, previousRoute);
    }
  }
}
