import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/pages/room/friend/widget/dot_widget.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class FriendPage extends GetView<FriendController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/screen1.png'),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
                left: 15,
                child: Bouncing(
                  onPress: (){
                    Get.back();
                  },
                  child: Image.asset('assets/image/button back.png', height: 55,),
                )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Image.asset('assets/image/friend.png', height: 110,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: DottedBorder(
                    padding: EdgeInsets.all(5),
                    strokeWidth: 2,
                    dashPattern: [10, 8],
                    borderType: BorderType.RRect,
                    color: Color(0xffEA702B),
                    radius: Radius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.asset('assets/image/search.png', height: 35,),
                          SizedBox(width: 5,),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: TextStyle(fontSize: 20),
                              cursorColor: Color(0xffEA702B),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Image.asset('assets/image/x.png', height: 35,),
                        ],
                      ),
                    )
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemCount: 10,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              DotWidget(dashColor: Color(0xffEA702B),),
                              SizedBox(height: 15,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/image/avatar.png', height: 50,),
                                  Column(
                                    children: [
                                      Text('PLAYER NAME',
                                          style: TextStyle(
                                            color: Color(0xffE86F2A), fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript',
                                          )
                                      ),
                                      Text('LEVEL 30',
                                          style: TextStyle(
                                            color: Color(0xffE86F2A), fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'KaushanScript',
                                          )
                                      ),
                                    ],
                                  ),
                                  Bouncing(
                                    onPress: (){},
                                      child: Image.asset('assets/image/option.png', height: 50,)
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                            ],
                          );
                        }
                    ),
                  ),
                ),
                SizedBox(height: 55,),
              ],
            ),
          ],
        ),
      )
    );
  }
}