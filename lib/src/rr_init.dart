
import 'package:flutter/material.dart';
import 'package:flutter_rr_toast/src/rr_manager.dart';

import 'initiate.dart';

final GlobalKey<RRToastManagerState> _key = GlobalKey<RRToastManagerState>();

RRToastManagerState get rrToastManager {
  assert(_key.currentState != null);
  return _key.currentState!;
}

class RRToastWidgetsBindingObserver with WidgetsBindingObserver {
  RRToastWidgetsBindingObserver._() : _listener = <PopTestFunc>[] {
    //Compatible with flutter 3.x
    (WidgetsBinding.instance as dynamic).addObserver(this);
  }

  final List<PopTestFunc> _listener;

  static final RRToastWidgetsBindingObserver _singleton =
      RRToastWidgetsBindingObserver._();

  static RRToastWidgetsBindingObserver get singleton => _singleton;

  VoidCallback registerPopListener(PopTestFunc popTestFunc) {
    _listener.add(popTestFunc);
    return () {
      _listener.remove(popTestFunc);
    };
  }

  @override
  Future<bool> didPopRoute() async {
    if (_listener.isNotEmpty) {
      final clone = _listener.reversed.toList(growable: false);
      for (PopTestFunc popTest in clone) {
        if (popTest()) return true;
      }
    }
    return super.didPopRoute();
  }
}

// ignore: non_constant_identifier_names
TransitionBuilder RRToastInit() {
  //Init this before materialApp

  //ignore: unnecessary_statements
  RRToastWidgetsBindingObserver._singleton;
  return (_, Widget? child) {
    return RRToastManager(key: _key, child: child!);
  };
}
