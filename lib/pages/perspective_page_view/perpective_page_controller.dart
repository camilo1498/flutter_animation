import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerspectiveController extends GetxController with GetTickerProviderStateMixin{

  /// variables
  List<Photo> photoList = [];
  double pageOffset = 2.0;
  late AnimationController animController;

  PageController pageController = PageController(
  initialPage: 2,
  viewportFraction: 0.4
  );


  @override
  void onInit() async{
    await getPhoto();
    super.onInit();
    animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }


  getPhoto() async {
    await GetService.getNatureImageList(maxImages: '10').then((list) {
      photoList = list;
      update(['photo_list', 'main_page']);
    });
  }

  onTapItem(index) {
    Get.toNamed(AppRoutes.detailPage, arguments: {
      'id': index,
      'photo_detail': photoList[index]
    });
  }

  listenPageOffset(ValueNotifier<double> value) {
    pageOffset = value.value;
    animController.value = value.value / photoList.length;
    update(['photo_list']);
  }

}