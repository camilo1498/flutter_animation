import 'dart:math';

import 'package:animations/routes/app_routes.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class HeroAnimationController extends GetxController {

  onTapNextPage() {
    Get.toNamed(AppRoutes.heroDetailPage,);
  }

}
