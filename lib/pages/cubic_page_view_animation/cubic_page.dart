import 'dart:math';
import 'dart:ui';

import 'package:animations/pages/cubic_page_view_animation/cubic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CubicPage extends StatelessWidget {
  const CubicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<CubicController>(
      id: 'photo_list',
      builder: (ctrl) => Scaffold(
        body: PageView.builder(
          controller: ctrl.pageController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            List<Widget> items = ctrl.photoList.map((item) {
              final int index = ctrl.photoList.indexOf(item);
              print(index);
              return Transform(
                transform:  Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(-degToRad(lerpDouble(0, 90, (index - ctrl.pageOffset))!)),
                alignment: (index - ctrl.pageOffset) <= 0 ? FractionalOffset.centerRight : FractionalOffset.centerLeft,
                child: SizedBox(
                  width: screenUtil.screenWidth,
                  height: screenUtil.screenHeight,
                  child: Image.network(
                    item.src!.medium!,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList();

            return items[index];

          },
        ),
      ),
    );
  }
}

double degToRad(double deg) => deg * (pi / 180.0);
double radToDeg(double rad) => rad * (180.0 / pi);