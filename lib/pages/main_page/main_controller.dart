import 'package:animations/pages/list_animation/list_animation_controller.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:get/get.dart';

class MainController extends GetxController {

  onTapScaleButton() {
    Get.toNamed(AppRoutes.listAnimationPage, arguments: {
      'scale_anim': ListAnimType.scale
    });
  }

  onTapLeftRightButton() {
    Get.toNamed(AppRoutes.listAnimationPage, arguments: {
      'scale_anim': ListAnimType.translate
    });
  }

  onTapRatateButton() {
    Get.toNamed(AppRoutes.listAnimationPage, arguments: {
      'scale_anim': ListAnimType.rotation
    });
  }

  onTapScrollTabBar() {
    Get.toNamed(AppRoutes.scrollTabBarPage);
  }

}