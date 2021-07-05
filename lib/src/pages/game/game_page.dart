import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/pages/game/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GamePage extends GetView<GameController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<GameController>(
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/screen 2.png')
                  )
              ),
              child: Column(children: <Widget>[
                Score(controller.xTurn, controller.xScore, controller.oScore,),
                SizedBox(height: 33,),
                Board(controller.tapFunc, controller.label, controller.end),
              ]),
            );
          }),
    );
  }
}


