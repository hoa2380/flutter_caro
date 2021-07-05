import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Score extends StatelessWidget {
  bool xTurn;
  int oScore;
  int xScore;
  @override
  Score(this.xTurn, this.oScore, this.xScore,);
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Bouncing(
                  onPress: (){
                    Get.back();
                  },
                  child: Image.asset('assets/image/button back.png', width: 55, height: 55,),
                ),
                Column(
                  children: [
                    Image.asset('assets/image/avatar.png', height: 50,),
                    Text('Player X',
                      style: TextStyle(
                        color: Color(0xffE86F2A), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript',
                      )
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    '$xScore',
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
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
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Center(
                                  child: Text(
                                    '$oScore',
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'),
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
                    Image.asset('assets/image/avatar.png', height: 50,),
                    Text('Player O',
                      style: TextStyle(
                          color: Color(0xffE86F2A), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'
                      ),
                    )
                  ],
                ),
                Bouncing(
                  onPress: (){},
                  child: Image.asset('assets/image/option.png', width: 55, height: 55,),
                ),
              ]),
            ]));
  }
}