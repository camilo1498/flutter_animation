import 'package:animations/routes/app_routes.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  onTapScaleButton() {
    Get.toNamed(AppRoutes.listAnimationPage, arguments: {
      'scale_anim': true
    });
  }

  onTapLeftRightButton() {
    Get.toNamed(AppRoutes.listAnimationPage, arguments: {
      'scale_anim': false
    });
  }

  onTapScrollTabBar() {
    Get.toNamed(AppRoutes.scrollTabBarPage);
  }

}