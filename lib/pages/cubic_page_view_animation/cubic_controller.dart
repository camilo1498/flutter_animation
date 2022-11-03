import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CubicController extends GetxController {
  /// variables
  List<Photo> photoList = [];
  double pageOffset = 0.0;

  /// controllers
  PageController pageController = PageController();

  @override
  void onInit() async{
    pageController.addListener(() {
      pageOffset = pageController.page!;
      update(['photo_list']);
    });
    await getPhoto();
    super.onInit();
  }

  getPhoto() async {
    await GetService.getNatureImageList(maxImages: '5').then((list) {
      photoList = list;
      update(['photo_list', 'main_page']);
    });
  }

}