import 'package:animations/pages/perspective_page_view/perpective_page_controller.dart';
import 'package:get/get.dart';

class PerspectiveBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerspectiveController());
  }
}