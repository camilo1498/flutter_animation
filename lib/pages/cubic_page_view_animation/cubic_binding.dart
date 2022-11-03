import 'package:animations/pages/cubic_page_view_animation/cubic_controller.dart';
import 'package:get/get.dart';

class CubicBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CubicController());
  }
}