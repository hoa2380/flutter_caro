import 'package:caro_flutter/src/pages/room/room_page.dart';
import 'package:caro_flutter/src/widgets/avatar_widget.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Score extends StatelessWidget {
  bool turnPlayer;
  bool ready1;
  bool ready2;
  int oScore;
  int xScore;
  String player1Name;
  String player2Name;
  Function leaveRoom;
  @override
  Score(
      {this.turnPlayer,
        this.ready1,
        this.ready2,
        this.oScore,
        this.xScore,
        this.player1Name,
        this.player2Name,
      this.leaveRoom});
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Color(0xffE7E8E8),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(60)
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Bouncing(
                    onPress: (){
                      // dialogLeaveRoom();
                      leaveRoom();
                    },
                    child: Image.asset('assets/image/button back.png', width: 55, height: 55,),
                  ),
                  Column(
                    children: [
                      AvatarWidget(
                        url: 'assets/image/icon-player.png',
                        height: 50,
                        width: 50,
                        color: ready1 ? Colors.yellow : Colors.white,
                      ),
                      Text(player1Name,
                          style: TextStyle(
                            color: Color(0xffE86F2A), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript',
                          )
                      ),
                      Container(
                        height: 5,
                        width: 70,
                        color: turnPlayer ? Colors.transparent : Colors.amberAccent,
                      )
                    ],
                  ),
                  Center(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset('assets/image/x.png', height: 40,),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Center(
                                    child: Text(
                                      '$xScore',
                                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 15,),
                          Column(
                            children: [
                              Image.asset('assets/image/o.png', height: 40,),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Center(
                                    child: Text(
                                      '$oScore',
                                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                  ),
                  Column(
                    children: [
                      AvatarWidget(
                        url: 'assets/image/icon-player.png',
                        height: 50,
                        width: 50,
                        color: ready2 ? Colors.yellow : Colors.white,
                      ),
                      Text(player2Name,
                        style: TextStyle(
                            color: Color(0xffE86F2A), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 70,
                        color: turnPlayer ? Colors.amberAccent : Colors.transparent,
                      )
                    ],
                  ),
                  Bouncing(
                    onPress: (){},
                    child: Image.asset('assets/image/option.png', width: 55, height: 55,),
                  ),
                ]),
              ]),
        ));
  }
  dialogLeaveRoom() {
      showDialog(
          context: Get.context,
          builder: (_) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm Leave Room',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                          fontFamily: 'KaushanScript'),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Bouncing(
                            onPress: () {
                              // leaveRoom();
                              Get.to(() => RoomPage());
                            },
                            child: ButtonWidget(
                              height: 50,
                              width: 120,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'Leave Room',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Bouncing(
                            onPress: () {
                              Get.back();
                            },
                            child: ButtonWidget(
                              height: 50,
                              width: 120,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'Exit',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                      ],
                    ),

                  ],
                ));
          });
  }
}
