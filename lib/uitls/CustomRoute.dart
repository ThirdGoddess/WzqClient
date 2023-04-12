// ignore_for_file: file_names
import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  final int type;

  CustomRoute(this.widget, this.type)
      : super(
            transitionDuration: const Duration(milliseconds: 500), //动画时间
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              switch (type) {
                case 3: //淡入淡出
                  return fadeTransitionNew(animation1, child);
                case 2: //缩放路由动画
                  return scaleTransitionNew(animation1, child);
                case 1: //旋转+缩放路由动画
                  return rotationTransitionNew(animation1, child);
                case 0: //左右滑动路由动画
                  return slideTransitionNew(animation1, child);
                default:
                  return slideTransitionNew(animation1, child);
              }
            });

  //淡入淡出
  static fadeTransitionNew(Animation<double> animation1, Widget child) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }

  //缩放路由动画
  static scaleTransitionNew(Animation<double> animation1, Widget child) {
    return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
        child: child);
  }

  //旋转+缩放路由动画
  static rotationTransitionNew(Animation<double> animation1, Widget child) {
    return RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
        child: ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
          child: child,
        ));
  }

  //左右滑动路由动画
  static slideTransitionNew(Animation<double> animation1, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
          .animate(
              CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
      child: child,
    );
  }
}
