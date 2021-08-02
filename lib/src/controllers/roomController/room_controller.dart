import 'dart:convert';
import 'package:caro_flutter/src/model/model.dart';
import 'package:caro_flutter/src/model/ready.dart';
import 'package:caro_flutter/src/model/room_play.dart';
import 'package:caro_flutter/src/pages/room/room_page.dart';
import 'package:caro_flutter/src/routes/app_pages.dart';
import 'package:caro_flutter/src/widgets/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class RoomController extends GetxController {
  var listRoom = <ListRoom>[].obs;
  var userName = ''.obs;
  var profilePicture = ''.obs;
  var player1Name = 'PLayer X'.obs;
  var player2Name = ''.obs;
  TextEditingController roomPassword;
  String roomName;
  Socket socket;
  final _isLoading = true.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) {
    _isLoading.value = value;
  }
  final _turnPlayer = false.obs;
  int xScore = 0;
  int oScore = 0;
  final _end = false.obs;
  int filledBoxes = 0;
  var checkWin = CheckWin().obs;
  var error = Error().obs;
  var roomPLay = RoomPLay().obs;
  var playerReady = Ready().obs;
  final _hideReady = true.obs;
  final _player1Ready = false.obs;
  final _player2Ready = false.obs;

  get hideReady => _hideReady.value;

  set hideReady(value) {
    _hideReady.value = value;
  }

  get player2Ready => _player2Ready.value;

  set player2Ready(value) {
    _player2Ready.value = value;
  }

  get player1Ready => _player1Ready.value;

  set player1Ready(value) {
    _player1Ready.value = value;
  }

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
    connectSocket();
    getInfoUser();
    roomPassword = TextEditingController();
    roomName = '';
    super.onInit();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('userName');
    profilePicture.value = prefs.getString('profilePicture');
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
    socket.connect();
    socket.onConnect((_) {
      print('connected');
    });
    socket.on('roomInfo', (data) {
      if (data != null) {
        listRoom.value = List.from(data).map((e) => ListRoom.fromJson(e)).toList();
        isLoading = false;
        print(jsonEncode(listRoom));
      }
    });
    socket.on('successCreateRoom', (data) {
      print(data);
      Get.toNamed(Routes.play_online);
    });
    socket.on('successJoinRoom', (data) {
      print(data);
      Get.toNamed(Routes.play_online);
    });
    socket.on('isReady', (data) => print(data));
    socket.on('gameStart', (data) => print(data));
    socket.on('yourTurn', (data) => print(data));
    eventPlayerReady();
    eventCheckWin();
    eventUpdateRoom();
    eventUpdateListRoom();
    eventError();
  }

  void eventPlayerReady() {
    socket.on('playerReady', (data){
      playerReady.value = Ready.fromJson(data);
      print(jsonEncode(playerReady));
      if(playerReady.value.player.role == 1){
        player1Ready = !player1Ready;
      } else if(playerReady.value.player.role == 2){
        player2Ready = !player2Ready;
      }
    });
  }

  void eventCheckWin() {
    socket.on('checkWin', (data) {
      checkWin.value = CheckWin.fromJson(data);
      print(jsonEncode(checkWin));
      for(var i = 0; i < checkWin.value.listMoves.length; i++){
        var x = checkWin.value.listMoves[i].x;
        var y = checkWin.value.listMoves[i].y;
        if(turnPlayer && label[x][y] == ''){
          label[x][y] = 'O';
          filledBoxes += 1;
          turnPlayer = !turnPlayer;
        }else if (!turnPlayer &&label[x][y] == ''){
          label[x][y] = 'X';
          filledBoxes += 1;
          turnPlayer = !turnPlayer;
        }
      }
    });
  }

  void eventUpdateRoom() {
    socket.on('updateRoom', (data){
      if(data != null){
        roomPLay.value = RoomPLay.fromJson(data);
        print(jsonEncode(roomPLay));
        final event = roomPLay.value.event;
        final player = roomPLay.value.data;
          if(event == 'joinRoom'){
            reload();
            for(var i = 0; i <= player.players.length; i++) {
              if(player.players[i].role == 1) {
                final snackBar = GetBar(title: 'You are player O', message: '-_-', duration: Duration(seconds: 2),);
                Get.showSnackbar(snackBar);
                player1Name.value = 'PLayer X';
              } else if(player.players[i].role == 2) {
                final snackBar = GetBar(title: roomPLay.value.message, message: '-_-', duration: Duration(seconds: 2),);
                Get.showSnackbar(snackBar);
                player2Name.value = 'Player O';
              }
            }
          } else if(event == 'leaveRoom'){
            for(var i = 0; i <= player.players.length; i++){
              if(player.players[i].role == 1) {
                final snackBar = GetBar(title: roomPLay.value.message, message: '-_-', duration: Duration(seconds: 2),);
                Get.showSnackbar(snackBar);
                player2Name.value = '';
                player1Ready = false;
                hideReady = true;
                reload();
              } else if(player.players[i].role == 2) {
                final snackBar = GetBar(title: roomPLay.value.message, message: '-_-', duration: Duration(seconds: 2),);
                Get.showSnackbar(snackBar);
                player2Ready = false;
                hideReady = true;
                player1Name.value = '';
                reload();
              }
            }
          } else if(event == 'winGame'){
            if(roomPLay.value.type == true){
              for(var i = 0; i <= player.players.length; i++){
                if(player.players[i].role == 1){
                  player2Ready = true;
                  player1Name.value = '';
                  winner();
                } else if(player.players[i].role == 2){
                  player2Name.value = '';
                  player1Ready = true;
                  winner();
                }
              }
            } else if(roomPLay.value.type == false) {
              for(var i = 0; i <= player.players.length; i++){
                if(player.players[i].role == 1){
                  showWinner();
                }
              }
            }
          }
      }
    });
  }

  void eventUpdateListRoom() {
    socket.on('updateListRoom', (data) {
      if (data != null) {
        listRoom.value = List.from(data).map((e) => ListRoom.fromJson(e)).toList();
        print("Player create new room " + jsonEncode(listRoom));
      }
    });
  }

  void eventError() {
    socket.on('Error', (data) {
      error.value = Error.fromJson(data);
      print(jsonEncode(error));
      var err = error.value;
      if(err.event == 'joinRoom') {
        final snackBar = GetBar(title: 'Join room fail', message: err.message, duration: Duration(seconds: 2),);
        Get.showSnackbar(snackBar);
      } else if(err.event == 'moves') {
        final snackBar = GetBar(title: 'Move fail', message: err.message, duration: Duration(seconds: 2),);
        Get.showSnackbar(snackBar);
      }
    });
  }


  //emit
  void ready() {
    socket.emit('reqReady');
  }

  void createRoom() {
    socket.emit('createRoom', {'password': roomPassword.text});
  }

  void joinRoom() {
    socket.emit('joinRoom', {'roomName': roomName, 'password': roomPassword.text});
  }

  void autoJoinRoom() {
    socket.emit('autoJoinRoom');
  }

  void leaveRoom() {
    socket.emit('leaveRoom');
    Get.back();
    hideReady = true;
    player1Ready = false;
    player2Ready = false;
    xScore = 0;
    oScore = 0;
    end = false;
    filledBoxes = 0;
    for (int i = 0; i < label.length; i++) {
      for (int j = 0; j < label[i].length; j++) {
        label[i][j] = '';
      }
    }
  }

  ///////////////////////////////////////////////

  void tapFunc(int x, int y) async {
    // turnPlayer = room.value.turn;
    if (label[x][y] != '') {
      print('Move did exist!');
      return;
    } else {
      socket.emit('moves', {'x': x, 'y': y});
    }
  }

  void showDraw() {
    dialogResult('Draw', 'Draw');
    end = !end;
  }

  void showWinner() async {
    dialogResult('Player X Win', 'Player O Win');
    // await Audio.playAsset(AudioType.victory);
    turnPlayer ? xScore += 1 : oScore += 1;
    end = !end;
  }

  void winner() async {
    dialogResult('You won', 'You won' );
    // await Audio.playAsset(AudioType.victory);
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
                          hideReady = !hideReady;
                          player1Ready = !player1Ready;
                          player2Ready = !player2Ready;
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
                          Get.to(() => RoomPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff73CDD6)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Leave Room',
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
