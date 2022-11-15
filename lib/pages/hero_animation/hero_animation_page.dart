import 'package:animations/pages/hero_animation/hero_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HeroAnimationPage extends StatelessWidget {
  const HeroAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<HeroAnimationController>(
      builder: (ctrl) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar(
                size: 60.w,
                rating: 5,
              ),
              40.verticalSpace,

              GestureDetector(
                onTap: ctrl.onTapNextPage,
                child: Container(
                  height: 80.h,
                  width: screenUtil.screenWidth,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text(
                    'next',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class RatingBar extends StatelessWidget {
  final int rating;
  final double size;

  const RatingBar({super.key,
    required this.rating,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Hero(
          tag: 'ratingStar$index',
          createRectTween: (begin, end) {
            return _createRectTween(begin!, end!, index)!;
          },
          child: Icon(
            index + 1 < rating ? Icons.star : Icons.star_border,
            color: Colors.red,
            size: size,
          ),
        );
      }),
    );
  }

  static RectTween? _createRectTween(Rect begin, Rect end, int index) {
    switch (index) {
      case 0:
        return CustomRectTween(
            begin: begin, end: end, cubic: const Cubic(0.19, 1.0, 0.22, 1.0));
      case 1:
        return CustomRectTween(
            begin: begin, end: end, cubic: const Cubic(0.23, 1.0, 0.32, 1.0));
      case 2:
        return CustomRectTween(
            begin: begin, end: end, cubic: const Cubic(0.165, 0.84, 0.44, 1.0));
      case 3:
        return CustomRectTween(
            begin: begin, end: end, cubic: const Cubic(0.215, 0.61, 0.355, 1.0));
      case 4:
        return CustomRectTween(
            begin: begin, end: end, cubic: const Cubic(0.25, 0.46, 0.45, 0.94));
    }
    return null;
  }
}

class CustomRectTween extends RectTween {
  late final Cubic _cubic;

  CustomRectTween({required Rect begin, required Rect end, required Cubic cubic})
      : super(begin: begin, end: end) {
    _cubic = cubic;
  }

  @override
  Rect lerp(double t) {
    double height = end!.top - begin!.top;
    double width = end!.left - begin!.left;

    double transformedY = _cubic.transform(t);

    double animatedX = begin!.left + (t * width);
    double animatedY = begin!.top + (transformedY * height);

    return Rect.fromLTWH(animatedX, animatedY, 1, 1);
  }
}