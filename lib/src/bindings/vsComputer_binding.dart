import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:get/get.dart';

class VsComputerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VsComputerController>(() => VsComputerController());
  }

}