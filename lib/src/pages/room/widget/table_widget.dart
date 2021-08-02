import 'package:caro_flutter/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final int  playerQuanity;

  TableWidget({this.playerQuanity,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AvatarWidget(
                url:
                'assets/image/icon-player.png',
                height: 50,
                width: 50,
                color: Colors.white,
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/image/table.png',
                        height: 80,
                      ),
                      Text(
                        '$playerQuanity/2',
                        style: TextStyle(
                          fontSize: 20, color: Color(0xffE86F2A), fontWeight: FontWeight.bold, fontFamily: 'KaushanScript'
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              AvatarWidget(
                url:
                'assets/image/icon-player.png',
                height: 50,
                width: 50,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
