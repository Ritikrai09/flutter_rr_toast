import 'dart:ui';

import 'package:flutter/material.dart';

class MotionLogo extends StatefulWidget {
  const MotionLogo({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.borderColor,
    this.duration,
    this.curve,
    // this.decochild,
    this.image,
  }) ;  
//  final Widget? decochild;
 final Widget? image;
 final Duration? duration;
 final Curve? curve;
 final Color? borderColor;
 final double? radius,width,height;

  @override
  State<MotionLogo> createState() => _MotionLogoState();
}

class _MotionLogoState extends State<MotionLogo>  with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    // Configure the animation controller
    _animationController = AnimationController(
      duration: widget.duration ??const Duration(seconds: 1),
      vsync: this,

    )..repeat(reverse: true);

    // Configure the animation
    curvedAnimation= CurvedAnimation(parent: _animationController, curve: widget.curve ?? Curves.easeInOut);
    _animation = Tween<double>(begin:0.5 , end: 1.0).animate(_animationController);
     _animation2 = Tween<double>(begin: 0.94 , end: 1.0).animate(_animationController);
  }

   @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
     animation: _animation,
     builder: (context, child) {
       return ScaleTransition(   
         scale: _animation2,
         child: Container(
           width: 50,
           height: 50, 
           decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
             borderRadius: BorderRadius.circular(16 ),
             border: Border.all(
               color: Theme.of(context).cardColor,
               width: lerpDouble(2.0, 4.0, _animation.value)!,
             ),
           ),
           child: Center(
             child:Container(
           width:50,
           height: 50,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(widget.radius ?? 16),
             border: Border.all(
               color: widget.borderColor ?? Theme.of(context).cardColor,
               width: lerpDouble(1.0, 2.0, _animation.value)!,
             ),
           ),
            child : widget.image ?? const MyCircularProgressIndicator(),
           )
           ),
         ),
       );
     },
    );
  }
}



class MyCircularProgressIndicator extends StatefulWidget {
  const MyCircularProgressIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyCircularProgressIndicatorState createState() => _MyCircularProgressIndicatorState();
}

class _MyCircularProgressIndicatorState extends State<MyCircularProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(seconds: 2), // Customize the animation duration here
    );

    // You can also use different easing curves for the animation
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    // If you want the animation to repeat, uncomment the following line:
     _animationController.repeat();

    // If you want the animation to reverse after completing, uncomment the following line:
    // _animationController.repeat(reverse: true);

    // If you want to control the animation from a certain range (e.g., 50% to 100%), use Tween:
    // _animation = Tween(begin: 0.5, end: 1.0).animate(_animationController);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CircularProgressIndicator(
              value: _animation.value,
            );
          },
        );
  }
}