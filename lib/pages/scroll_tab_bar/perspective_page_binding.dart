import 'package:animations/pages/scroll_tab_bar/perpective_page_controller.dart';
import 'package:get/get.dart';

class PerspectiveBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerspectiveController());
  }
}