import 'package:animations/core/hex_color.dart';
import 'package:animations/pages/detail_page/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil screenUtil = ScreenUtil();
    return GetBuilder<DetailController>(
      builder: (ctrl) => Scaffold(
        body: Hero(
          tag: ctrl.id.toString(),
          child: Container(
            color: HexColor.fromHex(ctrl.photoDetail.avgColor!),
            child: SizedBox(
              width: screenUtil.screenWidth,
              height: screenUtil.screenHeight,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /// image
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 0.8,
                                blurRadius: 5
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )
                      ),
                      child: SizedBox(
                        height: 600.h,
                        width: screenUtil.screenWidth,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                            ),
                            child: Image(
                              image: NetworkImage(ctrl.photoDetail.src!.medium!),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    50.verticalSpace,


                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        child: SizedBox(
                          width: screenUtil.screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// photograph name
                              Text(
                                ctrl.photoDetail.photographer!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Text(
                                ctrl.photoDetail.alt!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}