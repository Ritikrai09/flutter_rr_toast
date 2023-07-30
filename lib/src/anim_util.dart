import 'package:flutter/material.dart';

// @immutable
class AnimateRepeat extends StatefulWidget {
  final Duration duration;
  final double deltaX;
  final Widget child;
  final Curve curve;

  const AnimateRepeat({
    Key? key, 
    this.duration = const Duration(milliseconds: 300),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimateRepeat> createState() => _AnimateRepeatState();
}

class _AnimateRepeatState extends State<AnimateRepeat>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();  
  }

  /// convert 0-1 to 0-1-0
  double shake(double animation) =>
      2 * (0.5 - (0.5 - widget.curve.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(widget.deltaX * controller.value, 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class AnimationFadeSlide extends StatefulWidget {
  const AnimationFadeSlide(
      {Key? key,
      this.dy = 0.5,
      this.dx = 0,
      required this.controller,
      this.duration = const Duration(milliseconds: 300),
      this.reverse=false,
      this.curve,
      this.play = true,
      this.repeat=false,
      required this.child})
      : super(key: key);
  final Widget child;
  final double dx, dy;
  final bool play,repeat,reverse;
  final Curve? curve;
  final Duration duration;
  final AnimationController controller;
  @override
  State<AnimationFadeSlide> createState() => _AnimationFadeSlideState();
}

class _AnimationFadeSlideState extends State<AnimationFadeSlide>
    with SingleTickerProviderStateMixin {

  late CurvedAnimation animation;
  late Animation<Offset> offset;

  @override
  void initState() {
    
    animation = CurvedAnimation(
        parent: widget.controller, curve: widget.curve ?? Curves.easeIn)  ;
    offset = animation.drive(Tween<Offset>(
            begin: Offset(widget.dx, widget.dy), end: const Offset(0, 0))
        .chain(CurveTween(curve: Curves.ease)));
    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else 
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    if (widget.reverse == false) {
      widget.controller.forward();
    }else{
      widget.controller.reverse(); 
    }
    
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimationFadeSlide oldWidget) {
    if (oldWidget.reverse == widget.reverse) {
     widget.repeat == false ?null 
     :widget.controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: FadeTransition(
        opacity: animation,
         child: widget.child),
    );
  }
}

class AnimationFadeScale extends StatefulWidget {
  const AnimationFadeScale(
      {Key? key,
      this.duration = 500,
      this.fadeIn = true,
      this.curve,
      required this.controller,
      this.scale=0.65,
      this.reverse= false,
      required this.child})
      : super(key: key);
  final Widget child;
  final bool fadeIn, reverse;
  final int duration;
  final double scale;
  final AnimationController controller;
  final Curve? curve;
  @override
  State<AnimationFadeScale> createState() => _AnimationFadeScaleState();
}

class _AnimationFadeScaleState extends State<AnimationFadeScale>
    with SingleTickerProviderStateMixin {

  late CurvedAnimation animation;
  late Animation<double> scale;
   static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  @override
  void initState() {
    animation = CurvedAnimation(
        parent: widget.controller, curve: widget.curve ?? Curves.easeIn);
    scale = animation.drive(Tween<double>(
            begin: widget.fadeIn ? 0 :widget.scale, end: widget.fadeIn ? 1 : 0)
        .chain(CurveTween(curve: Curves.ease)));
    /*animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else 
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    if (widget.reverse == true) {
      widget.controller.forward();
    }else{
      widget.controller.reverse();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: FadeTransition(
          opacity: animation.drive(tweenOpacity.chain(CurveTween(curve: Curves.ease))),
          child: widget.child),
    );
  }
}
