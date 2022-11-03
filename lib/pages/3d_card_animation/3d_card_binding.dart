import 'package:animations/pages/3d_card_animation/3d_card_controller.dart';
import 'package:get/get.dart';

class Card3DBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Card3DController());
  }
}