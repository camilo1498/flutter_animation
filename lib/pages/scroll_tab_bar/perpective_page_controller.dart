import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerspectiveController extends GetxController with GetSingleTickerProviderStateMixin{

  /// controllers
  final PageController pageController= PageController(initialPage: 2, viewportFraction: 0.50);
  List<Photo> photoList = [];
  double holder = 2.0;


  @override
  void onInit() async{
    await getPhoto();
    super.onInit();
    pageController.addListener(() {
      holder = pageController.page!;
      update(['photo_list']);
    });
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

}