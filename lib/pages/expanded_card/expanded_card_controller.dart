import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ExpandedCardController extends GetxController with GetTickerProviderStateMixin{

  late final AnimationController animController;
  bool expanded = false;
  double currentHeight = 0.0;
  double currentVal = 0.0;

  @override
  void onInit() {
    animController = AnimationController(vsync: this, duration: 1200.milliseconds);
    super.onInit();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  double positionedHeight(double value, double minHeight, double maxHeight) {
    currentHeight = maxHeight;
    return lerpDouble(minHeight, maxHeight, value) ?? 0.0;
  }

  onTaoNavBar(double maxHeight) {
    currentHeight = maxHeight;
    expanded = !expanded;
    update();
    if(expanded) {
      animController.reverse();
    } else {
      animController.forward(from: 0);
      currentHeight = maxHeight;

    }
  }



}