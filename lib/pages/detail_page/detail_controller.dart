import 'package:animations/data/models/search_image_res.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {

  /// variables
  late Photo photoDetail;
  int id = 0;
  @override
  void onInit() {
    if(Get.arguments != null) {
      photoDetail = Get.arguments['photo_detail'];
      id = Get.arguments['id'];
    }
    super.onInit();
  }

  onTapBackButton() {
    Get.back();
  }

}