import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_controller.dart';
import 'package:get/get.dart';

class ExpandableNavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpandableNavBarController());
  }
}