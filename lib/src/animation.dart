import 'package:flutter/material.dart';
import 'anim_util.dart';
import 'initiate.dart';

Widget notificationAnimation(
        AnimationController controller,double dx,double dy,CancelFunc cancelFunc, Widget child) =>
    AnimationFadeSlide(dy: dy,dx: dx,reverse: true, controller: controller, child: child);

Widget textAnimation(
        AnimationController controller,double dx ,double dy, CancelFunc cancelFunc, Widget child) =>
    AnimationFadeSlide(dy: dy,dx: dx,controller: controller, child: child);

Widget loadingAnimation(
        AnimationController controller,double dx,double dy, CancelFunc cancelFunc, Widget child) =>
    AnimationFadeScale(controller: controller, child: child);

Widget attachedAnimation(
        AnimationController controller,double dx,double dy, CancelFunc cancelFunc, Widget child) =>
    AnimationFadeSlide(controller: controller, child: child);
