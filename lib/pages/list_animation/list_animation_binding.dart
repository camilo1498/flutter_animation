import 'package:animations/pages/list_animation/list_animation_controller.dart';
import 'package:get/get.dart';

class ListAnimationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListAnimationController());
  }
}