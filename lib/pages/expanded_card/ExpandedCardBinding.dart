import 'package:animations/pages/expanded_card/expanded_card_controller.dart';
import 'package:get/get.dart';

class ExpandedCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpandedCardController());
  }
}