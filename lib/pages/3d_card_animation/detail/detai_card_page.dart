import 'package:animations/pages/3d_card_animation/detail/detail_card_controller.dart';
import 'package:animations/pages/3d_card_animation/widgets/card_3d_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailCardPage extends StatelessWidget {
  const DetailCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailCardController>(
      id: 'detail_page',
      builder: (ctrl) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card3DWidget(
                photo: ctrl.photoList,
                index: ctrl.index,
                onCardSelected: (photo){},
                animation: ctrl.animationMovementController,

              ),
            ],
          ),
        ),
      ),
    );
  }
}