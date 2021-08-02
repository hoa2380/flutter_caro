import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/pages/room/play_online/widget/board.dart';
import 'package:caro_flutter/src/pages/room/play_online/widget/score.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PLayOnlinePage extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX<RoomController>(builder: (_) {
          return Container(
            color: Color(0xff73CDD6),
            child: Stack(
              children: [
                Column(
                    children: <Widget>[
                      Score(
                        leaveRoom: controller.leaveRoom,
                        turnPlayer: controller.turnPlayer,
                        ready1: controller.player1Ready,
                        ready2: controller.player2Ready,
                        xScore: controller.xScore,
                        oScore: controller.oScore,
                        player1Name: controller.player1Name.value,
                        player2Name: controller.player2Name.value,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Board(controller.tapFunc, controller.label, controller.end,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                GetX<RoomController> (
                  builder: (_) {
                    return Visibility(
                      visible: controller.hideReady,
                      child: Center(
                        child: Bouncing(
                            onPress: () {
                              controller.hideReady = !controller.hideReady;
                              controller.ready();
                              controller.restart();
                            },
                            child: ButtonWidget(
                              height: 50,
                              width: 130,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'ready'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}