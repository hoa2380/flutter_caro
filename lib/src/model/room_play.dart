class RoomPLay {
  RoomPLay({
    this.message,
    this.playerId,
    this.data,
    this.event,
    this.type,
  });

  String message;
  String playerId;
  Data data;
  String event;
  bool type;

  factory RoomPLay.fromJson(Map<String, dynamic> json) => RoomPLay(
    message: json["message"],
    playerId: json["playerID"],
    data: Data.fromJson(json["data"]),
    event: json["event"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "playerID": playerId,
    "data": data.toJson(),
    "event": event,
    "type": type,
  };
}

class Data {
  Data({
    this.req,
    this.players,
    this.banList,
    this.status,
    this.type,
    this.turn,
    this.disconnectCount,
    this.id,
    this.roomName,
    this.password,
    this.roomMaster,
    this.v,
  });

  Req req;
  List<Player> players;
  List<dynamic> banList;
  int status;
  int type;
  bool turn;
  int disconnectCount;
  String id;
  String roomName;
  String password;
  String roomMaster;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    req: Req.fromJson(json["req"]),
    players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
    banList: List<dynamic>.from(json["banList"].map((x) => x)),
    status: json["status"],
    type: json["type"],
    turn: json["turn"],
    disconnectCount: json["disconnectCount"],
    id: json["_id"],
    roomName: json["roomName"],
    password: json["password"],
    roomMaster: json["roomMaster"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "req": req.toJson(),
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
    "banList": List<dynamic>.from(banList.map((x) => x)),
    "status": status,
    "type": type,
    "turn": turn,
    "disconnectCount": disconnectCount,
    "_id": id,
    "roomName": roomName,
    "password": password,
    "roomMaster": roomMaster,
    "__v": v,
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

class Req {
  Req({
    this.reqReturn,
    this.reqTime,
    this.reqNewGame,
  });

  dynamic reqReturn;
  dynamic reqTime;
  dynamic reqNewGame;

  factory Req.fromJson(Map<String, dynamic> json) => Req(
    reqReturn: json["reqReturn"],
    reqTime: json["reqTime"],
    reqNewGame: json["reqNewGame"],
  );

  Map<String, dynamic> toJson() => {
    "reqReturn": reqReturn,
    "reqTime": reqTime,
    "reqNewGame": reqNewGame,
  };
}
