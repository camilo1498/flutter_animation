import 'package:animations/data/models/search_image_res.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class DetailCardController extends GetxController with GetSingleTickerProviderStateMixin{

  late AnimationController animationMovementController;
  late Photo photoList;
  late int index;

  @override
  void onInit() {
   // animationMovementController = AnimationController(vsync: this, duration: 800.milliseconds);
    if(Get.arguments != null) {
      photoList = Get.arguments['photo'];
      index = Get.arguments['index'];
       animationMovementController = Get.arguments['animated_controller'];
    }
    super.onInit();
  }
}