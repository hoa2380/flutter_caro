class Ready {
  Ready({
    this.message,
    this.player,
  });

  String message;
  Player player;

  factory Ready.fromJson(Map<String, dynamic> json) => Ready(
    message: json["message"],
    player: Player.fromJson(json["player"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "player": player.toJson(),
  };
}

class Player {
  Player({
    this.winGame,
    this.loseGame,
    this.drawGame,
    this.role,
    this.isReady,
    this.isReconnect,
    this.id,
    this.userId,
    this.socketId,
    this.point,
    this.v,
    this.timerReconnectId,
  });

  int winGame;
  int loseGame;
  int drawGame;
  int role;
  bool isReady;
  bool isReconnect;
  String id;
  String userId;
  String socketId;
  int point;
  int v;
  int timerReconnectId;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    winGame: json["winGame"],
    loseGame: json["loseGame"],
    drawGame: json["drawGame"],
    role: json["role"],
    isReady: json["isReady"],
    isReconnect: json["isReconnect"],
    id: json["_id"],
    userId: json["userID"],
    socketId: json["socketID"],
    point: json["point"],
    v: json["__v"],
    timerReconnectId: json["timerReconnectID"],
  );

  Map<String, dynamic> toJson() => {
    "winGame": winGame,
    "loseGame": loseGame,
    "drawGame": drawGame,
    "role": role,
    "isReady": isReady,
    "isReconnect": isReconnect,
    "_id": id,
    "userID": userId,
    "socketID": socketId,
    "point": point,
    "__v": v,
    "timerReconnectID": timerReconnectId,
  };
}
