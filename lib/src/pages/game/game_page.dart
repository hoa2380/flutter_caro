import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/pages/game/widget/board.dart';
import 'package:caro_flutter/src/pages/game/widget/score.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GamePage extends GetView<GameController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetX<GameController>(builder: (_) {
          return Container(
            color: Color(0xff73CDD6),
            child: Column(
                children: <Widget>[
                  Score(
                    controller.turnPlayer,
                    controller.xScore,
                    controller.oScore,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Board(controller.tapFunc, controller.label, controller.end,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
          );
        }),
      ),
    );
  }
}



