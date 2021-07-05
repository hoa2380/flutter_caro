import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:get/get.dart';

class GameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(() => GameController());
  }

}