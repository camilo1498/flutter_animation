import 'package:animations/pages/3d_card_animation/3d_card_binding.dart';
import 'package:animations/pages/3d_card_animation/3d_card_page.dart';
import 'package:animations/pages/3d_card_animation/detail/detail_card_binding.dart';
import 'package:animations/pages/3d_card_animation/detail/detai_card_page.dart';
import 'package:animations/pages/cubic_page_view_animation/cubic_binding.dart';
import 'package:animations/pages/cubic_page_view_animation/cubic_page.dart';
import 'package:animations/pages/detail_page/detail_binding.dart';
import 'package:animations/pages/detail_page/detail_page.dart';
import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_binding.dart';
import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_page.dart';
import 'package:animations/pages/list_animation/list_animation_binding.dart';
import 'package:animations/pages/list_animation/list_animation_page.dart';
import 'package:animations/pages/main_page/main_binding.dart';
import 'package:animations/pages/main_page/main_page.dart';
import 'package:animations/pages/scroll_tab_bar/perspective_page_binding.dart';
import 'package:animations/pages/scroll_tab_bar/perspective_page.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:get/get.dart';
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
    GetPage(
        name: AppRoutes.card3DPage,
        page: () => const Card3DPage(),
        binding: Card3DBinding()
    ),
    GetPage(
        name: AppRoutes.detailCardPage,
        page: () => const DetailCardPage(),
        binding: DetailCardBinding()
    ),
    GetPage(
        name: AppRoutes.cubicPage,
        page: () => const CubicPage(),
        binding: CubicBinding()
    ),
    GetPage(
        name: AppRoutes.expandableNavBar,
        page: () => const ExpandableNavBarPage(),
        binding: ExpandableNavBarBinding()
    ),
  ];
}