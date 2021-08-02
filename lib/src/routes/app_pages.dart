import 'package:caro_flutter/src/bindings/binding.dart';
import 'package:caro_flutter/src/pages/room/play_online/play_online_page.dart';
import 'package:caro_flutter/src/pages/room/room_page.dart';
import 'package:get/get.dart';
import 'package:caro_flutter/src/pages/pages.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.room,
      page: () => RoomPage(),
      binding: RoomBinding(),
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
      name: Routes.play_online,
      page: () => PLayOnlinePage(),
      binding: PlayOnlineBinding(),
    ),

  ];
}