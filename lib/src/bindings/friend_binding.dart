import 'package:caro_flutter/src/controllers/friend/friend_controller.dart';
import 'package:get/get.dart';

class FriendBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendController>(() => FriendController());
  }

}