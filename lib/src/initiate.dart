import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///Toast
typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef FutureFunc = Future<void> Function();
typedef PopTestFunc = bool Function();

typedef WrapWidget = Widget Function(CancelFunc cancelFunc, Widget widget);
typedef WrapAnimation = Widget Function(
    AnimationController controller,double dx ,double dy,CancelFunc cancelFunc, Widget widget);

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

// BackButtonBehavior 
enum BackButtonBehavior {
  ///None
  none,

  ///Ignore Toast
  ignore,

  ///Close Toast
  close
}
//PreferredDirection
//topLeft,topCenter,topRight,bottomLeft,bottomCenter,
// bottomRight,leftTop,leftCenter,leftBottom,rightTop,rightCenter,rightBottom,

enum PreferDirection {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom,
}
