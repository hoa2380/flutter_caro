class MiniMaxAi {
  int checkCount = 0;
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
  ];
  int countRow = 0;
  int countCol = 0;
  int countDia1 = 0;
  int countDia2 = 0;
  bool blockedHead = false;
  bool blockedTail = false;
  int col = 12;
  int row = 12;
  int filledBoxes = 0;
  String message = '';

  move(i , j, availablePositions) {
    int bestScore = -9;
    var bestMove;
    checkCount = 0;
    for (int i = 0; i < label.length; i++) {
      for (int j = 0; j < label.length; j++) {
        if (label[i][j].isEmpty) {
          label[i][j] = 'O';
          var score = minimax(i, j, 0, false);
          label[i][j] = '';
          if (score > bestScore) {
            bestScore = score;
            bestMove = label[i][j];
          }
        }
      }
    }
    print(checkCount);
    if (availablePositions.length > 4) label[bestMove] = 'O';
    return checkCount;
  }

  var scores = {
    'X': -10,
    'O': 10,
    'DRAW': 0,
  };

  minimax(i, j,  depth, isMaximizingPlayer) {
    checkCount++;
    var result = checkAiWinner(i, j);
    if (result != 'NONE') {
      return scores[result];
    }

    if (isMaximizingPlayer) {
      int bestScore = -999999999;
      for (int i = 0; i < label.length; i++) {
        for (int j = 0; j < label.length; j++) {
          if (label[i][j].isEmpty) {
            label[i] = 'O';
            var score = minimax(i, j, depth + 1, false);
            label[i][j] = '';
            //alpha = max<double>(alpha, score);
            //if (beta <= alpha) break;
            if (score > bestScore) {
              bestScore = score;
            }
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 999999999;
      for (int i = 0; i < label.length; i++) {
        for (int j = 0; j < label.length; i++) {
          if (label[i][j].isEmpty) {
            label[i][j] = 'X';
            var score = minimax(i, j, depth + 1, true);
            label[i][j] = '';
            //beta = min<double>(beta, score);
            //if (beta <= alpha) break;
            if (score < bestScore) {
              bestScore = score;
            }
          }
        }
      }
      return bestScore;
    }
  }

  checkAiWinner(int row, int col) {
    countRow = 0;
    countCol = 0;
    countDia1 = 0;
    countDia2 = 0;
    blockedHead = false;
    blockedTail = false;
    //check HORIZONTAL line
    for (var i = col; i >= 0; i--) {
      var current = this.label[row][i];
      if (current == 'O') {
        countRow++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = col + 1; i < this.col; i++) {
      var current = this.label[row][i];
      if (current == 'O') {
        countRow++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countRow == 5 && !(blockedTail && blockedHead)) return showWinner();

    // check for the VERTICAL line
    for (var i = row; i >= 0; i--) {
      var current = this.label[i][col];
      if (current == 'O') {
        countCol++;
      } else if (current != '') {
        blockedHead = true;
        break;
      } else
        break;
    }
    for (var i = row + 1; i < this.row; i++) {
      var current = this.label[i][col];
      if (current == 'O') {
        countCol++;
      } else if (current != '') {
        blockedTail = true;
        break;
      } else
        break;
    }
    if (countCol == 5 && !(blockedTail && blockedHead)) return showWinner();

    // check diagonal right
    for (var i = row, j = col; i >= 0 && j >= 0; i--, j--) {
      var current = this.label[i][j];
      if (current == 'O') {
        countDia1++;
      }
      else if (current != '') {
        blockedHead = true;
        break;
      }
      else
        break;
    }
    for (var i = row + 1, j = col + 1; i < this.row && j < this.col; i++, j++) {
      var current = this.label[i][j];
      if (current == 'O') {
        countDia1++;
      }
      else if (current != '') {
        blockedTail = true;
        break;
      }
      else
        break;
    }
    if (countDia1 == 5 && !(blockedTail && blockedHead)) return showWinner();

    // check diagonal left
    for (var i = row, j = col; i >= 0 && j < this.col; i--, j++) {
      var current = this.label[i][j];
      if (current == 'O') {
        countDia2++;
      }
      else if (current != '') {
        blockedHead = true;
        break;
      }
      else
        break;
    }
    for (var i = row + 1, j = col - 1; i < this.row && j >= 0; i++, j--) {
      var current = this.label[i][j];
      if (current == 'O') {
        countDia2++;
      }
      else if (current != '') {
        blockedTail = true;
        break;
      }
      else
        break;
    }
    if (countDia2 == 5 && !(blockedTail && blockedHead)) return showWinner();

    // Draw
    if (filledBoxes == 144) {
      message = 'Draw';
    }
  }

  void showWinner() {
    message = 'O Win';
  }
}