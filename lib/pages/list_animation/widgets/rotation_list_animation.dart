import 'package:animations/core/hex_color.dart';
import 'package:animations/pages/list_animation/list_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RotatedListAnimation extends StatelessWidget {
  const RotatedListAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<ListAnimationController>(
      id: 'photo_list',
      builder: (photo) => SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return  Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            child: GestureDetector(
              onTap: () => photo.onTapItem(index),
              child: Hero(
                tag: '$index',
                child: AnimatedOpacity(
                  duration: 300.milliseconds,
                  opacity: photo.getOpacityByElement(index, false),
                  child: Transform.rotate(
                    /// Transform.rotate config
                    angle: 1 - photo.getOpacityByElement(index, true),
                    alignment: Alignment.bottomCenter,

                    child: Container(
                      decoration: BoxDecoration(
                          color: HexColor.fromHex(photo.photoList[index].avgColor!),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 0.8,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: SizedBox(
                          height: 400.h,
                          width: screenUtil.screenWidth,
                          child: Stack(
                            children: [
                              /// image
                              SizedBox(
                                height: 400.h,
                                width: screenUtil.screenWidth,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      image: NetworkImage(photo.photoList[index].src!.medium!),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),

                              /// photograph name
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(20.w),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                        photo.photoList[index].photographer!,
                                        style: const TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
          childCount: photo.photoList.length,
        ),
      ),
    );
  }
}