import 'package:animations/pages/list_animation/list_animation_controller.dart';
import 'package:animations/pages/list_animation/widgets/right_left_animation.dart';
import 'package:animations/pages/list_animation/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListAnimationPage extends StatelessWidget {
  const ListAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<ListAnimationController>(
      id: 'main_page',
      builder: (ctrl) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text(
            'Animated Scroll List',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
        body: ctrl.photoList.isNotEmpty
            ? Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: CustomScrollView(
          controller: ctrl.scrollController,
          slivers: [
              if(ctrl.scaleAnim)
                const ScaleListAnimation()
              else
                const RightLeftAnimation()
          ],
        ),
            )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}