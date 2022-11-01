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
              /// tab bar
              SafeArea(
                child: Container(
                  width: screenUtil.screenWidth,
                  height: 200.h,
                  child: TabBar(
                    controller: ctrl.tabController,
                  physics: const BouncingScrollPhysics(),
                  isScrollable: true,
                  indicator: const BoxDecoration(),
                  tabs: [
                    _tabItem(
                      title: 'item 1',
                      onTap: (){},
                      selected: true
                    ),
                    _tabItem(
                        title: 'item 1',
                        onTap: (){}
                    ),
                    _tabItem(
                        title: 'item 1',
                        onTap: (){}
                    ),
                    _tabItem(
                        title: 'item 1',
                        onTap: (){}
                    ),
                    _tabItem(
                        title: 'item 1',
                        onTap: (){}
                    ),
                  ],
                  ),
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

  Widget _tabItem({
  required Function() onTap,
    required String title,
    bool selected = false,

}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: selected ? FontWeight.bold : FontWeight.w400
          ),
        ),
      ),
    );
  }
}