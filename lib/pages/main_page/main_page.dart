import 'package:animations/pages/main_page/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<MainController>(
      builder: (ctrl) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: SizedBox(
                width: screenUtil.screenWidth,
                height: screenUtil.screenHeight - screenUtil.statusBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _button(
                        title: 'Scale list view',
                        onTap: ctrl.onTapScaleButton
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Right / Left list view',
                        onTap: ctrl.onTapLeftRightButton
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Rotated list view',
                        onTap: ctrl.onTapRatateButton
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Perspective PageView',
                        onTap: ctrl.onTapScrollTabBar
                    ),

                    30.verticalSpace,

                    _button(
                        title: '3D Card',
                        onTap: ctrl.onTap3DCard
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Cubic Page View',
                        onTap: ctrl.onTapCubicPageView
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Expandable nav bar',
                        onTap: ctrl.onTapExpandableNavBar
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Hero animations',
                        onTap: ctrl.onTapHeroAnimation
                    ),
                    30.verticalSpace,

                    _button(
                        title: 'Charts',
                        onTap: ctrl.onTapCharts
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button ({required String title, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red
        ),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15
          ),
        ),
      ),
    );
  }
}