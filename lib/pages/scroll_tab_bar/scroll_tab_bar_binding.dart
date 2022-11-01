import 'package:animations/pages/scroll_tab_bar/scroll_tab_bar_controller.dart';
import 'package:get/get.dart';

class ScrollTabBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScrollTabBarController());
  }
}