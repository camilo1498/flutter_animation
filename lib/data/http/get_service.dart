import 'package:animations/data/models/search_image_res.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class GetService {

  static Future<List<Photo>> getNatureImageList({String page = '1', String maxImages = '10'}) async {
    try {
      final Response res = await Dio().get(
          'https://api.pexels.com/v1/search?query=nature&page=$page&per_page=$maxImages',
          options: Options(
            headers: {
              'Authorization': '563492ad6f91700001000001d2bd319812fc4d58af823a0769e2d2a9'
            }
          )
      );
      final decodeRes = res.data;
      if(decodeRes != null && decodeRes['photos'].isNotEmpty) {

        final List<Photo> list = [];
        for(var item in  decodeRes['photos']) {
          list.add(Photo.fromJson(item));
        }
        return list;
      } else {
        return [];
      }
    } on DioError catch(e) {
      debugPrint(e.response.toString());
      return [];
    }
  }
}