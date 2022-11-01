import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollTabBarController extends GetxController with GetSingleTickerProviderStateMixin{

  /// controllers
  late TabController tabController;



  @override
  void onInit() {
    tabController = TabController(length: 5, vsync: this);
    super.onInit();
  }
}