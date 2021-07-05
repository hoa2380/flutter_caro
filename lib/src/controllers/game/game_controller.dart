import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final _oTurn = false.obs;
  String message = '';
  int xScore = 0;
  int oScore = 0;
  final _end = false.obs;
  int filledBoxes = 0;
  int countRow, countCol, countDia1, countDia2 = 0;
  int col = 12;
  int row = 12;
  bool blockedHead, blockedTail = false;
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

  get xTurn => _oTurn.value;

  set xTurn(value) {
    _oTurn.value = value;
  }

  get end => _end.value;

  set end(value) {
    _end.value = value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    showDialog(
      context: Get.context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Image.asset('assets/image/Untitled-1.png', height: 120,),
        );
      },
    );
    Future.delayed(Duration(milliseconds: 1000), () {
      Get.back();
    });
    super.onReady();
  }

  void tapFunc(int i, int j) {
    if (label[i][j] != '') {
      print('Move did exist!');
      return;
    } else if (xTurn && label[i][j] == '') {
      label[i][j] = 'O';
      filledBoxes += 1;
      xTurn = !xTurn;
      checkWinner(i, j, 'O');
    } else if (!xTurn && label[i][j] == '') {
      label[i][j] = 'X';
      filledBoxes += 1;
      xTurn = !xTurn;
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
    if (filledBoxes == 144) {
      showDraw();
    }
  }

  void showDraw() {
    message = 'Draw';
    end = !end;
  }

  void showWinner() {
    Get.defaultDialog(
        barrierDismissible: false,
        title: xTurn ? message = 'Player X Win!' : message = 'Player O Win!',
        titleStyle: TextStyle(
            fontSize: 56, color: xTurn ? Color(0xffEA702B) : Color(0xffC3272E)
        ),
        content: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  restart();
                  Get.back();
                },
                child: Text('Play again'))
          ],
        ));
    xTurn ? oScore += 1 : xScore += 1;
    end = !end;
  }

  void restart() {
    message = '';
    xTurn = false;
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
    message = '';
    end = false;
    xTurn = false;
    filledBoxes = 0;
    for (int i = 0; i < label.length; i++) {
      for (int j = 0; j < label[i].length; j++) {
        label[i][j] = '';
      }
    }
  }

//Play with Bot

}
