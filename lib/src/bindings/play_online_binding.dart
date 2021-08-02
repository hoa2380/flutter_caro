import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:get/get.dart';

class PlayOnlineBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayOnlineController>(() => PlayOnlineController());
  }

}