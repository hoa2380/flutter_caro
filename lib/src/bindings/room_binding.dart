import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:get/get.dart';

class RoomBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomController>(() => RoomController());
  }

}