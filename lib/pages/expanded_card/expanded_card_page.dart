import 'dart:ui';

import 'package:animations/pages/expanded_card/expanded_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpandedCardPage extends StatefulWidget {
  const ExpandedCardPage({Key? key}) : super(key: key);

  @override
  State<ExpandedCardPage> createState() => _ExpandedCardPageState();
}

class _ExpandedCardPageState extends State<ExpandedCardPage> {

  final ScreenUtil screenUtil = ScreenUtil();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpandedCardController>(
      builder: (ctrl) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(4, (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ExpandedContainer(
                    firstChild: Container(
                      color: Colors.grey,
                      width: screenUtil.screenWidth,
                      height: screenUtil.screenHeight * 0.05,
                    ),
                    secondChild: Container(
                    height: screenUtil.screenHeight *( index * 0.1),
                  width: screenUtil.screenWidth,
                  color: Colors.white,
                  ),
                  ),
                )).toList()
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandedContainer extends StatefulWidget {
  final Widget firstChild;
  final Widget secondChild;
  const ExpandedContainer({
    Key? key,
    required this.firstChild,
    required this.secondChild
  }) : super(key: key);

  @override
  State<ExpandedContainer> createState() => _ExpandedContainerState();
}

class _ExpandedContainerState extends State<ExpandedContainer>  with SingleTickerProviderStateMixin{

  /// controllers
  late AnimationController animationController;

  /// variables
  bool expanded = false;
  double currentFirstHeight = 0.0;
  double currentSecondHeight = 0.0;

  GlobalKey firstKey = GlobalKey();
  GlobalKey secondKey = GlobalKey();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getSizes();
    });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  _getSizes() {
    final RenderBox renderFirst = firstKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox renderSecond = secondKey.currentContext!.findRenderObject() as RenderBox;
    final sizeFirst = renderFirst.size;
    final sizeSecond = renderSecond.size;
    setState(() {
      currentFirstHeight = sizeFirst.height;
      currentSecondHeight = sizeSecond.height;
    });
  }

  double positionedHeight(double value, double minHeight, double maxHeight) {
    currentFirstHeight = maxHeight;
    return lerpDouble(minHeight, maxHeight, value) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final value = const ElasticInOutCurve(0.7).transform(animationController.value);
        return GestureDetector(
          onTap: () {
            setState(() {
              _getSizes();
              expanded = !expanded;
            });
            if(expanded) {
              animationController.reverse();
            } else {
              animationController.forward(from: 0);
            }
          },
          child: Container(
            width: screenUtil.screenWidth,
            height: positionedHeight(value, currentSecondHeight, currentFirstHeight),
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 4
                  )
                ]
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                 SizedBox(
                   key: firstKey,
                   child: widget.firstChild,
                 ),
                  Column(
                    key: secondKey,
                    children: [
                      20.verticalSpace,
                      widget.secondChild
                    ],
                  )

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}