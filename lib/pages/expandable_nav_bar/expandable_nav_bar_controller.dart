import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ExpandableNavBarController extends GetxController with GetTickerProviderStateMixin{

  /// variables
  final double maxHeight = 350.0;
  final double minHeight = 70.0;
  double currentHeight = 0.0;
  bool expanded = false;

  /// controllers
  late AnimationController animController;

  @override
  void onInit() {
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    super.onInit();
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }

  onVerticalDragUpdate(DragUpdateDetails details) {
    final newHeight = currentHeight - details.delta.dy;
    animController.value = currentHeight / maxHeight;
    currentHeight = newHeight.clamp(minHeight, maxHeight);
    update();
  }

  onVerticalDragEnd(DragEndDetails details) {
    if(currentHeight < maxHeight / 1.5) {
      animController.reverse();
      expanded = false;
    } else {
      expanded = true;
      animController.forward(from: currentHeight / maxHeight);
      currentHeight = maxHeight;
    }
  }

  onTaoNavBar() {
    currentHeight = maxHeight;
    animController.forward(from: 0);
    expanded = true;
    update();
  }

  double positionedHeight(double value) {
    return lerpDouble(minHeight, currentHeight, value) ?? 0.0;
  }

  double positionedLeft(double width, double menuWidth,double value) {
    return lerpDouble((width / 2) - (menuWidth / 2), 0, value) ?? 0.0;
  }

  double positionedWidth(double width, double menuWidth,double value) {
    return lerpDouble(menuWidth, width, value)?? 0.0;
  }

  double positionedBottom(double value) {
    return lerpDouble(40.0, 0, value) ?? 0.0;
  }

  double borderRadius(double value) {
    return lerpDouble(20, 0, value)?? 0.0;
  }

}