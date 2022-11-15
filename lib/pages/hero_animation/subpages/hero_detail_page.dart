import 'package:animations/pages/hero_animation/hero_animation_controller.dart';
import 'package:animations/pages/hero_animation/hero_animation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<HeroAnimationController>(
        builder: (ctrl) => Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: screenUtil.screenWidth,
              height: screenUtil.screenHeight,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20),
                child: RatingBar(
                  size: 60.w,
                  rating: 5,
                ),
              ),
            ),
          ),
        )
    );
  }
}