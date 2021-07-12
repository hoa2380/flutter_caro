import 'package:caro_flutter/src/bindings/binding.dart';
import 'package:get/get.dart';
import 'package:caro_flutter/src/pages/pages.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.game,
      page: () => GamePage(),
      binding: GameBinding(),
    ),
    GetPage(
      name: Routes.friend,
      page: () => FriendPage(),
      binding: FriendBinding(),
    ),
    GetPage(
      name: Routes.computer,
      page: () => VsComputerPage(),
      binding: VsComputerBinding(),
    ),

  ];
}