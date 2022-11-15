import 'package:animations/pages/3d_card_animation/3d_card_binding.dart';
import 'package:animations/pages/3d_card_animation/3d_card_page.dart';
import 'package:animations/pages/3d_card_animation/detail/detail_card_binding.dart';
import 'package:animations/pages/3d_card_animation/detail/detai_card_page.dart';
import 'package:animations/pages/charts/charts_page.dart';
import 'package:animations/pages/cubic_page_view_animation/cubic_binding.dart';
import 'package:animations/pages/cubic_page_view_animation/cubic_page.dart';
import 'package:animations/pages/detail_page/detail_binding.dart';
import 'package:animations/pages/detail_page/detail_page.dart';
import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_binding.dart';
import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_page.dart';
import 'package:animations/pages/expanded_card/ExpandedCardBinding.dart';
import 'package:animations/pages/expanded_card/expanded_card_page.dart';
import 'package:animations/pages/hero_animation/hero_animation_binding.dart';
import 'package:animations/pages/hero_animation/hero_animation_page.dart';
import 'package:animations/pages/hero_animation/subpages/hero_detail_page.dart';
import 'package:animations/pages/list_animation/list_animation_binding.dart';
import 'package:animations/pages/list_animation/list_animation_page.dart';
import 'package:animations/pages/main_page/main_binding.dart';
import 'package:animations/pages/main_page/main_page.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/perspective_page_view/perspective_page.dart';
import '../pages/perspective_page_view/perspective_page_binding.dart';

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
    GetPage(
        name: AppRoutes.heroAnimationPage,
        page: () => const HeroAnimationPage(),
        binding: HeroAnimationBinding()
    ),
    GetPage(
        name: AppRoutes.heroDetailPage,
        page: () => const HeroDetailPage(),
        binding: HeroAnimationBinding(),
      transitionDuration: 1.seconds
    ),
    GetPage(
        name: AppRoutes.chartsPage,
        page: () => const ChartsPage(),
    ),
    GetPage(
        name: AppRoutes.expandedCardPage,
        page: () => const ExpandedCardPage(),
        binding: ExpandedCardBinding(),
    ),
  ];
}