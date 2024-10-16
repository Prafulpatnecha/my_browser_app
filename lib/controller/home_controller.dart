import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

HomeGetController homeGetController = Get.put(HomeGetController());

class HomeGetController extends GetxController {


  HomeGetController()
  {
    historyGetMethod();
  }

  RxDouble progress = 0.0.obs;
  RxString linkUrl = "https://www.google.com/search?q=".obs;
  RxList<String> historyList = <String>[].obs;
  void progressMethed(var value) {
    progress.value = value / 100;
  }

  void linkUrlMethod(String value) {
    linkUrl.value = value;
  }

  Future<void> historySetMethod(String value)
  async {
    historyList.add(value);
    try{  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("history", historyList);
    }catch(e)
    {
      print("Problum");
    }
    // print(historyList);
  }
  Future<void> historyGetMethod()
  async {
    // try{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    historyList.value = sharedPreferences.getStringList("history") ?? [];
    // }catch(e)
    // {
    //   print("List Not Found");
    // }
  }
}
