import 'dart:ui';

import 'package:animations/pages/perspective_page_view/perpective_page_controller.dart';
import 'package:animations/pages/perspective_page_view/perspective_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PerspectivePage extends StatelessWidget {
  const PerspectivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<PerspectiveController>(
      id: 'photo_list',
      builder: (ctrl) => Scaffold(
          body: ctrl.photoList.isNotEmpty ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: 500.h,
                  width: screenUtil.screenWidth,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPerspectivePage(
                        pageController: ctrl.pageController,
                        child: [
                          ...ctrl.photoList.map((item) => Hero(
                            tag: ctrl.photoList.indexOf(item).toString(),
                            child: GestureDetector(
                              onTap: () => ctrl.onTapItem(ctrl.photoList.indexOf(item)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          offset: const Offset(0, 1),
                                          blurRadius: 0.1,
                                          spreadRadius: 1
                                      )
                                    ]
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image(
                                    image: NetworkImage(item.src!.medium!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                      0.verticalSpace,
                      SimplePageIndicator(
                          controller: ctrl.pageController,
                          itemCount: ctrl.photoList.length,
                        indicatorColor: Colors.red,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 500.h,
                  width: screenUtil.screenWidth,

                ),
              ],
            ),
          ) : const Center(
          child: CircularProgressIndicator(),
    ),
    )
    );
  }
}


class Card extends StatelessWidget {
  final int number;
  final double aspectRatio;
  final Widget child;
  final Color? shadowColor;
  final bool hasShadow;
  final double shadowScale;
  final double value;

  const Card({
    super.key,
    required this.child,
    required this.number,
    required this.aspectRatio,
    this.hasShadow = false,
    this.shadowColor,
    required this.shadowScale,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    double diff = (number - value);

    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9)
      ..setEntry(1, 1, aspectRatio)
      ..setEntry(3, 0, 0.004 * -diff);

    final Matrix4 shadowMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / shadowScale)
      ..setEntry(3, 1, -0.004)
      ..setEntry(3, 0, 0.002 * diff)
      ..rotateX(1.309);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        if (hasShadow && diff <= 1.0 && diff >= -1.0) ...[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: 1 - diff.abs(),
            child: Transform(
              alignment: FractionalOffset.bottomCenter,
              transform: shadowMatrix,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: shadowColor??Colors.black12, blurRadius: 10.0, spreadRadius: 1.0)
                ]),
              ),
            ),
          ),
        ],
        Transform(
          transform: pvMatrix,
          alignment: FractionalOffset.center,
          child: Container(
            child: child,
          ),
        ),
      ],
    );
  }
}

class Controller extends ChangeNotifier {
  double _holder = 2.0;

  double get holder => _holder;

  set holder(double value) {
    _holder = value;
    notifyListeners();
  }
}


class SimplePageIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;
  final Color indicatorColor;
  final double maxSize;
  final double minSize;
  final double space;

  const SimplePageIndicator(
      {Key? key,
        required this.controller,
        required this.itemCount,
        this.indicatorColor = Colors.grey,
        this.maxSize = 6,
        this.space = 14.0,
        this.minSize = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimatedItem);
  }

  Widget _buildAnimatedItem(BuildContext context, Widget? child) {

    int index;

    double? offset;


    if (!controller.hasClients || controller.page == null) {
      index = controller.initialPage;
      offset = controller.initialPage.toDouble();
    } else {
      index = controller.page! ~/ 1;
      offset = controller.page;
    }
    return CustomPaint(
      size: Size(
          maxSize * _kMaxCircleCount + space * (_kMaxCircleCount - 1), maxSize),
      painter: SimplePageIndicatorPainter(
          itemCount: itemCount,
          indicatorColor: indicatorColor,
          maxSize: maxSize,
          minSize: minSize,
          pageIndex: index,
          space: space,
          pageOffset: offset! - index,
          isStart:
          (offset > index) && (index + _kMaxCircleCount - 1 < itemCount),
          isEnd: index + _kMaxCircleCount - 2 >= itemCount),
    );
  }
}

const _kMaxCircleCount = 3;

class SimplePageIndicatorPainter extends CustomPainter {
  final int? itemCount;
  final Color? indicatorColor;
  final double? maxSize;
  final double? minSize;
  final int? pageIndex;
  final double? pageOffset;
  final double? space;
  final bool? isStart;
  final bool? isEnd;

  const SimplePageIndicatorPainter(
      {this.itemCount,
        this.indicatorColor,
        this.maxSize,
        this.space,
        this.minSize,
        this.pageIndex,
        this.pageOffset,
        this.isStart,
        this.isEnd});

  @override
  void paint(Canvas canvas, Size size) {

    Paint mPaint = Paint()
      ..color = indicatorColor!
      ..isAntiAlias = true;


    const centerCircleIndex = _kMaxCircleCount ~/ 2;

    double childWidth = size.width / _kMaxCircleCount;


    for (int i = 0; i < _kMaxCircleCount; i++) {

      if (pageIndex == 0 && i == 0) {
        continue;
      }
      if (isEnd! && i == _kMaxCircleCount - 1) {
        continue;
      }

      if (centerCircleIndex == i) {
        canvas.drawCircle(
            Offset(
                (i * childWidth) + (childWidth / 2) - childWidth * pageOffset!,
                childWidth / 2),
            maxSize! - (maxSize! - minSize!) * pageOffset!,
            mPaint..color = indicatorColor!);
      }

      else if (i < centerCircleIndex) {
        canvas.drawCircle(
            Offset(
                (i * childWidth) + (childWidth / 2) - childWidth * pageOffset!,
                childWidth / 2),
            minSize! * (1 - pageOffset!),
            mPaint..color = indicatorColor!.withOpacity(1 - pageOffset!));
      }

      else {
        canvas.drawCircle(
            Offset(
                (i * childWidth) + (childWidth / 2) - childWidth * pageOffset!,
                childWidth / 2),
            minSize! + (maxSize! - minSize!) * pageOffset!,
            mPaint..color = indicatorColor!);
      }
    }

    if (isStart! && !isEnd!) {
      canvas.drawCircle(
          Offset(
              (_kMaxCircleCount * childWidth) +
                  (childWidth / 2) -
                  childWidth * pageOffset!,
              childWidth / 2),
          minSize! * pageOffset!,
          mPaint..color = indicatorColor!.withOpacity(pageOffset!));
    }
  }

  @override
  bool shouldRepaint(covariant SimplePageIndicatorPainter oldDelegate) {
    return itemCount != oldDelegate.itemCount ||
        indicatorColor != oldDelegate.indicatorColor ||
        maxSize != oldDelegate.maxSize ||
        minSize != oldDelegate.minSize ||
        space != oldDelegate.space ||
        pageIndex != oldDelegate.pageIndex ||
        pageOffset != oldDelegate.pageOffset ||
        isStart != oldDelegate.isStart ||
        isEnd != oldDelegate.isEnd;
  }
}