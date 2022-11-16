import 'dart:ui';

import 'package:animations/pages/expanded_card/expanded_animated_container.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(4, (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: ExpandableAnimatedContainer(
                      curve: Curves.easeInOut,
                      firstChild: Container(
                        color: Colors.grey,
                        width: screenUtil.screenWidth,
                        height: screenUtil.screenHeight * 0.05,
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            Expanded(child: Text(ctrl.currentVal.toString()))
                          ],
                        ),
                      ),
                      secondChild: Container(
                      height: screenUtil.screenHeight *( index * 0.5),
                    width: screenUtil.screenWidth,
                    color: Colors.white,
                    ),
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