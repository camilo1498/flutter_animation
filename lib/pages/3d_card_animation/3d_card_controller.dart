import 'package:animations/data/http/get_service.dart';
import 'package:animations/data/models/search_image_res.dart';
import 'package:animations/routes/app_routes.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Card3DController extends GetxController with GetTickerProviderStateMixin{
  List<Photo> photoList = [];

  bool isOpen = false;

  late AnimationController animationController;
  late AnimationController animationMovementController;

  int selectedIndex = -1;

  @override
  void onInit() async{
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.15,
      upperBound: 0.5,
      duration: 500.milliseconds
    );

    animationMovementController = AnimationController(
        vsync: this,
        duration: 500.milliseconds
    );
    await getPhoto();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }


  getPhoto() async {
    await GetService.getNatureImageList(maxImages: '5').then((list) {
      photoList = list;
      update(['photo_list', 'main_page']);
    });
  }


  onTapList() {
    if(!isOpen) {
      animationController.forward().whenComplete(() {
        isOpen = true;
        update(['photo_list']);
      });
    } else {
      animationController.reverse().whenComplete(() {
        isOpen = false;
        update(['photo_list']);
      });
    }
  }

  onCardSelected(Photo photo, int  index) async{
    selectedIndex = index;
    update(['photo_list']);
    animationMovementController.forward();
    await Get.toNamed(AppRoutes.detailCardPage, arguments: {
      'photo': photo,
      'index': index,
      'animated_controller': animationMovementController
    });
    animationMovementController.reverse(from: 1.0);
  }

  getCurrentFactor(int index) {
    if(selectedIndex == index) {
       return 0;
    } else if(selectedIndex > index) {
      return -1;
    } else {
      return 1;
    }
  }

}