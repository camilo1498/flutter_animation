import 'package:animations/pages/expandable_nav_bar/expandable_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpandableNavBarPage extends StatelessWidget {
  const ExpandableNavBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    final double menuWidth = screenUtil.screenWidth * 0.5;
    return GetBuilder<ExpandableNavBarController>(
      builder: (ctrl) => Container(
        width: screenUtil.screenWidth,
        height: screenUtil.screenHeight,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: ListView.builder(
                itemCount: 15,
                padding: EdgeInsets.only(bottom: ctrl.minHeight + 100.h),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Container(
                    height: 600.h,
                    width: screenUtil.screenWidth,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onVerticalDragUpdate: ctrl.expanded ? ctrl.onVerticalDragUpdate : null,
              onVerticalDragEnd: ctrl.expanded ? ctrl.onVerticalDragEnd : null,
              child: AnimatedBuilder(
                animation: ctrl.animController,
                builder: (context, child) {
                  final value = const ElasticInOutCurve(0.7).transform(ctrl.animController.value);
                  return Stack(
                    children: [
                      Positioned(
                        height: ctrl.positionedHeight(value),
                        left: ctrl.positionedLeft(screenUtil.screenWidth, menuWidth, value),
                        width: ctrl.positionedWidth(screenUtil.screenWidth, menuWidth, value),
                        bottom: ctrl.positionedBottom(value),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.vertical(
                                  top: const Radius.circular(20),
                                  bottom: Radius.circular(ctrl.borderRadius(value))
                              )
                          ),
                          child: ctrl.expanded ? Opacity(
                            opacity: ctrl.animController.value,
                            child: _expandedWidget(),
                          ) : Opacity(
                            opacity: 1 - ctrl.animController.value,
                            child: _nonExpandedWidget(ctrl),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _expandedWidget() {
    final ScreenUtil screenUtil = ScreenUtil();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 300,
              width: screenUtil.screenWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nonExpandedWidget(ExpandableNavBarController ctrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 30,
          height: 30,
          color: Colors.white,
        ),

        GestureDetector(
          onTap: ctrl.onTaoNavBar,
          child: Container(
            width: 30,
            height: 30,
            color: Colors.white,
          ),
        ),

        Container(
          width: 30,
          height: 30,
          color: Colors.white,
        )
      ],
    );
  }
}