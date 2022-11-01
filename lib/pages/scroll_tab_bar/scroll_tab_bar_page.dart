import 'package:animations/pages/scroll_tab_bar/scroll_tab_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScrollTabBarPage extends StatelessWidget {
  const ScrollTabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<ScrollTabBarController>(
        builder: (ctrl) => Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: Container(
                  width: screenUtil.screenWidth,
                  height: 200.h,
                  color: Colors.red,
                ),
              ),

              Expanded(
                child: Container(

                ),
              )
            ],
          ),
        )
    );
  }
}