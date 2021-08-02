import 'package:caro_flutter/src/controllers/controllers.dart';
import 'package:caro_flutter/src/pages/room/widget/table_widget.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:caro_flutter/src/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomPage extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xff73CDD6),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffE7E8E8),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(60))),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Bouncing(
                            onPress: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/image/button back.png',
                              width: 55,
                              height: 55,
                            ),
                          ),
                          GetX<RoomController>(
                            builder: (_) {
                              return Column(
                                children: [
                                  // AvatarWidget(
                                  //   url: controller.profilePicture.value,
                                  //   height: 50,
                                  //   width: 50,
                                  // ),
                                  Text(controller.userName.value,
                                      style: TextStyle(
                                        color: Color(0xffE86F2A),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'KaushanScript',
                                      )),
                                  Text('Level 30',
                                      style: TextStyle(
                                        color: Color(0xffE86F2A),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'KaushanScript',
                                      )),
                                ],
                              );
                            },
                          ),
                          Bouncing(
                            onPress: () {},
                            child: Image.asset(
                              'assets/image/option.png',
                              width: 55,
                              height: 55,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    width: 150,
                    color: Color(0xffE86F2A),
                    child: Text(
                      'choose table'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'KaushanScript'),
                    ),
                  ),
                  GetX<RoomController>(
                    builder: (_) {
                      if (controller.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Expanded(
                        child: GridView.builder(
                            padding: EdgeInsets.only(bottom: 80),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 2,
                              crossAxisSpacing: 20,
                            ),
                            itemCount: controller.listRoom.length,
                            itemBuilder: (BuildContext ctx, index) {
                              final room = controller.listRoom;
                              return GestureDetector(
                                onTap: () {
                                  dialogJoinRoom(controller.roomName =
                                      room[index].roomName);
                                },
                                child: TableWidget(
                                  playerQuanity: room[index].players.length,
                                ),
                              );
                            }),
                      );
                    },
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffE7E8E8),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Bouncing(
                            onPress: () {
                              dialogCreateRoom();
                            },
                            child: ButtonWidget(
                              height: 40,
                              width: 110,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'create table'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                        Bouncing(
                            onPress: () {
                              controller.autoJoinRoom();
                            },
                            child: ButtonWidget(
                              height: 40,
                              width: 110,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'play now'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                        Bouncing(
                            onPress: () {},
                            child: ButtonWidget(
                              height: 40,
                              width: 110,
                              color: Color(0xffE86F2A),
                              child: Text(
                                'list friend'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KaushanScript'),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  dialogJoinRoom(String roomName) {
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
                    'RoomName: $roomName',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    color: Colors.white,
                    width: 350,
                    child: TextField(
                      controller: controller.roomPassword,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'RoomPassword'),
                      style: TextStyle(fontSize: 15),
                      cursorColor: Color(0xffEA702B),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Bouncing(
                      onPress: () async {
                        controller.joinRoom();
                        Future.delayed(Duration(milliseconds: 1000), () {
                          Get.back();
                        });
                      },
                      child: ButtonWidget(
                        height: 40,
                        width: 120,
                        color: Color(0xffE86F2A),
                        child: Text(
                          'join room'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KaushanScript'),
                        ),
                      )),
                ],
              ));
        });
  }

  dialogCreateRoom() {
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
                    'create room'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'KaushanScript'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(
                    color: Colors.white,
                    width: 350,
                    child: TextField(
                      controller: controller.roomPassword,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Password'),
                      style: TextStyle(fontSize: 15),
                      cursorColor: Color(0xffEA702B),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Bouncing(
                      onPress: () {
                        controller.createRoom();
                        Future.delayed(Duration(milliseconds: 1000), () {
                          Get.back();
                        });
                      },
                      child: ButtonWidget(
                        height: 40,
                        width: 120,
                        color: Color(0xffE86F2A),
                        child: Text(
                          'create room'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KaushanScript'),
                        ),
                      )),
                ],
              ));
        });
  }
}
