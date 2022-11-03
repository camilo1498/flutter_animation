import 'package:animations/pages/detail_page/detail_binding.dart';
import 'package:animations/pages/detail_page/detail_page.dart';
import 'package:animations/pages/list_animation/list_animation_binding.dart';
import 'package:animations/pages/list_animation/list_animation_page.dart';
import 'package:animations/pages/main_page/main_binding.dart';
import 'package:animations/pages/main_page/main_page.dart';
import 'package:animations/pages/scroll_tab_bar/perspective_page_binding.dart';
import 'package:animations/pages/scroll_tab_bar/perspective_page.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static List<GetPage> get appPages => [
    GetPage(
      name: AppRoutes.listAnimationPage,
      page: () => const ListAnimationPage(),
      binding: ListAnimationBinding()
    ),
    GetPage(
        name: AppRoutes.detailPage,
        page: () => const DetailPage(),
        binding: DetailBinding()
    ),
    GetPage(
        name: AppRoutes.mainPage,
        page: () => const MainPage(),
        binding: MainBinding()
    ),
    GetPage(
        name: AppRoutes.perspectivePage,
        page: () => const PerspectivePage(),
        binding: PerspectiveBinding()
    ),
  ];
}