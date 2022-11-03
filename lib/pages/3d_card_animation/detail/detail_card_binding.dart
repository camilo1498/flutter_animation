import 'package:animations/pages/3d_card_animation/detail/detail_card_controller.dart';
import 'package:get/get.dart';

class DetailCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailCardController());
  }
}