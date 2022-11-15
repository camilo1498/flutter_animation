import 'package:animations/pages/hero_animation/hero_animation_controller.dart';
import 'package:get/get.dart';

class HeroAnimationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HeroAnimationController());
  }
}