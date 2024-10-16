

import 'package:get/get.dart';
HomeGetController homeGetController = Get.put(HomeGetController());
class HomeGetController extends GetxController{
  RxDouble progress = 0.0.obs;
  RxString linkUrl = "https://www.google.com/search?q=".obs;

  void progressMethed(var value)
  {
    progress.value = value/100;
    
  }
    void linkUrlMethod(String value)
    {
      linkUrl.value = value;
    }
}