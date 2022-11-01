import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum ListAnimType {rotation, scale, translate}

class ListAnimationController extends GetxController {

  /// variables
  List<Photo> photoList = [];
  ListAnimType scaleAnim = ListAnimType.scale;

  /// controllers
  ScrollController scrollController = ScrollController();


  @override
  void onInit() async{
    if(Get.arguments != null) {
      scaleAnim = Get.arguments['scale_anim'];
      update(['main_page']);
    }
    await getPhoto();
    scrollController.addListener(() {
      update(['photo_list']);
    });
    super.onInit();
  }

  getPhoto() async {
    await GetService.getNatureImageList(maxImages: '30').then((list) {
      photoList = list;
      update(['photo_list', 'main_page']);
    });
  }

  double getOpacityByElement(int index, bool isScale) {
    final itemOffset = index * 420.h;
    final diff = scrollController.offset - itemOffset;
    final diffPercent = 1 - (diff / 420.h);
    double opacity = 1.0;

    if(diffPercent >= 0.0 && diffPercent <= 1.0) {
      opacity = diffPercent;
      return isScale ? diffPercent : opacity;
    } else if(diffPercent <= 0.0) {
      opacity = 0.0;
      return isScale ? 0.0 : opacity;
    } else {
      return isScale ? 1.0 : opacity;
    }
  }

  double getOffsetByElement(int index) {
    final itemOffset = index * 420.h;
    final diff = scrollController.offset - itemOffset;
    if(diff >= 0.0) {
      return index % 2 == 0 ? 0.h + diff : 0.h - diff;
    } else {
      return 0.0;
    }
  }

  onTapItem(index) {
    Get.toNamed(AppRoutes.detailPage, arguments: {
      'id': index,
      'photo_detail': photoList[index]
    });
  }

}