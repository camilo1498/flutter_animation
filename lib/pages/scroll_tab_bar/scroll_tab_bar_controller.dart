import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollTabBarController extends GetxController with GetSingleTickerProviderStateMixin{

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
    await GetService.getNatureImageList(maxImages: '30').then((list) {
      photoList = list;
      update(['photo_list', 'main_page']);
    });
  }

  Matrix4 pvMatrix(index, diff) {

    return Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9)
      ..setEntry(1, 1, 16/9)
      ..setEntry(3, 0, 0.004 * -diff);
  }

  Matrix4 shadowMatrix(index) {
    return Matrix4.identity()
      ..setEntry(3, 3, 1 / 1.6)
      ..setEntry(3, 1, -0.004)
      ..setEntry(3, 0, 0.002 * (index - 2-0))
      ..rotateX(1.309);
  }


}