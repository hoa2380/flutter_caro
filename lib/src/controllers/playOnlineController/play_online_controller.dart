import 'dart:convert';
import 'package:caro_flutter/src/model/login.dart';
import 'package:caro_flutter/src/model/room_play.dart';
import 'package:caro_flutter/src/services/audio.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class PlayOnlineController extends GetxController {
  final _turnPlayer = false.obs;
  int xScore = 0;
  int oScore = 0;
  final _end = false.obs;
  int filledBoxes = 0;
  int countRow, countCol, countDia1, countDia2 = 0;
  int col = 12;
  int row = 18;
  bool blockedHead, blockedTail = false;
  Socket socket;
  var data = Get.arguments;
  var user = <Login>[].obs;
  var room = RoomPLay().obs;
  var userName = ''.obs;
  List label = [
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
    List.generate(12, (_) => ''),
  ];

  get turnPlayer => _turnPlayer.value;

  set turnPlayer(value) {
    _turnPlayer.value = value;
  }

  get end => _end.value;

  set end(value) {
    _end.value = value;
  }

  @override
  void onInit() {
    getInfoRoom();
    connectSocket();
    super.onInit();
  }

  @override
  void onReady() async {
    showDialog(
      context: Get.context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Image.asset(
            'assets/image/Untitled-1.png',
            height: 120,
          ),
        );
      },
    );
    Future.delayed(Duration(milliseconds: 700), () {
      Get.back();
    });
    super.onReady();
  }

  void getListPLayer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('userName');
  }

  void getInfoRoom() {
    room.value = RoomPLay.fromJson(data);
    print("Join Room: " + jsonEncode(room));
  }

  void connectSocket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    socket = io(
        'https://co-caro.herokuapp.com/users',
        OptionBuilder()
            .setQuery({'token': token})
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.on('Error', (data) => print(data));
  }

  void leaveRoom() {
    socket.emit('leaveRoom');
  }

  void tapFunc(int i, int j) async {
    if (label[i][j] != '') {
      print('Move did exist!');
      return;
    } else if (turnPlayer && label[i][j] == '') {
      await Audio.playAsset(AudioType.xo);
      label[i][j] = 'O';
      filledBoxes += 1;
      turnPlayer = !turnPlayer;
      checkWinner(i, j, 'O');
    } else if (!turnPlayer && label[i][j] == '') {
      await Audio.playAsset(AudioType.xo);
      label[i][j] = 'X';
      filledBoxes += 1;
      turnPlayer = !turnPlayer;
      checkWinner(i, j, 'X');
    }
  }

  void checkWinner(int row, int col, String char) {
    countRow = 0;
    countCol = 0;
    countDia1 = 0;
    countDia2 = 0;
    blockedHead = false;
    blockedTail = false;
    //check HORIZONTAL line
    for (var i = col; i >= 0; i--) {
      var current = this.label[row][i];
      if (current == char) {
        countRow++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = col + 1; i < this.col; i++) {
      var current = this.label[row][i];
      if (current == char) {
        countRow++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countRow >= 5 && !(blockedTail && blockedHead)) return showWinner();

    // check for the VERTICAL line
    for (var i = row; i >= 0; i--) {
      var current = this.label[i][col];
      if (current == char) {
        countCol++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = row + 1; i < this.row; i++) {
      var current = this.label[i][col];
      if (current == char) {
        countCol++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countCol >= 5 && !(blockedTail && blockedHead)) return showWinner();

    // check diagonal right
    for (var i = row, j = col; i >= 0 && j >= 0; i--, j--) {
      var current = this.label[i][j];
      if (current == char) {
        countDia1++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = row + 1, j = col + 1; i < this.row && j < this.col; i++, j++) {
      var current = this.label[i][j];
      if (current == char) {
        countDia1++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countDia1 >= 5 && !(blockedTail && blockedHead)) return showWinner();

    // check diagonal left
    for (var i = row, j = col; i >= 0 && j < this.col; i--, j++) {
      var current = this.label[i][j];
      if (current == char) {
        countDia2++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = row + 1, j = col - 1; i < this.row && j >= 0; i++, j--) {
      var current = this.label[i][j];
      if (current == char) {
        countDia2++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countDia2 >= 5 && !(blockedTail && blockedHead)) return showWinner();

    // Draw
    if (filledBoxes == 216) {
      showDraw();
    }
  }

  void showDraw() {
    dialogResult('Draw', 'Draw');
    end = !end;
  }

  void showWinner() async {
    dialogResult('Player X Win', 'Player O Win');
    // await Audio.playAsset(AudioType.victory);
    turnPlayer ? xScore += 1 :  oScore += 1;
    end = !end;
  }

  void restart() {
    turnPlayer = false;
    end = false;
    filledBoxes = 0;
    for (int i = 0; i < label.length; i++) {
      for (int j = 0; j < label[i].length; j++) {
        label[i][j] = '';
      }
    }
  }

  void reload() {
    xScore = 0;
    oScore = 0;
    end = false;
    turnPlayer = false;
    filledBoxes = 0;
    for (int i = 0; i < label.length; i++) {
      for (int j = 0; j < label[i].length; j++) {
        label[i][j] = '';
      }
    }
  }

  dialogResult(String playerX, String playerO) {
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
                  turnPlayer ? playerX : playerO,
                  style: TextStyle(
                    fontSize: 50,
                    color: Color(0xff73CDD6),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'KaushanScript',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Bouncing(
                        onPress: () {
                          restart();
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff73CDD6)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Play Again',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KaushanScript',
                              ),
                            ),
                          ),
                        )),
                    Bouncing(
                        onPress: () {
                          reload();
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff73CDD6)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Reset Score',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KaushanScript',
                              ),
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ));
      },
    );
  }

}
