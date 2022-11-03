import 'package:animations/pages/3d_card_animation/3d_card_controller.dart';
import 'package:animations/pages/3d_card_animation/widgets/card_3d_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Card3DPage extends StatelessWidget {
  const Card3DPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<Card3DController>(
        id: 'photo_list',
        builder: (ctrl) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                /// appBar
                SizedBox(
                  height: 200.h,
                  width: screenUtil.screenWidth,
                ),

                /// body
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return AnimatedBuilder(
                        animation: ctrl.animationController,
                        builder: (context, snapshot) {
                          final selectionValue = ctrl.animationController.value;
                          return GestureDetector(
                            onTap: ctrl.onTapList,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateX(selectionValue),
                              child: AbsorbPointer(
                                absorbing: !ctrl.isOpen
                                ,
                                child: Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth * 0.9,
                                  color: Colors.white,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: List.generate(
                                      ctrl.photoList.length,
                                          (index) => Card3DItem(
                                        height: constraints.maxHeight / 2,
                                        photo: ctrl.photoList[index],
                                        percent: selectionValue,
                                        index: index,
                                        verticalFactor: ctrl.getCurrentFactor(index),
                                        animation: ctrl.animationMovementController,
                                        isForward: ctrl.animationMovementController.status ==
                                            AnimationStatus.forward,
                                        onCardSelected: (card) {
                                          ctrl.onCardSelected(card, index);
                                        },
                                      ),
                                    ).reversed.toList(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
                ),

                /// footer
                SizedBox(
                  height: 200.h,
                  width: screenUtil.screenWidth,
                  child: GestureDetector(
                    onTap: ctrl.onTapList,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}