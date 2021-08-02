class ListRoom {
  ListRoom({
    this.req,
    this.players,
    this.banList,
    this.status,
    this.type,
    this.turn,
    this.disconnectCount,
    this.id,
    this.roomName,
    this.roomMaster,
    this.v,
  });

  Req req;
  List<dynamic> players;
  List<dynamic> banList;
  int status;
  int type;
  bool turn;
  int disconnectCount;
  String id;
  String roomName;
  dynamic roomMaster;
  int v;

  factory ListRoom.fromJson(Map<String, dynamic> json) => ListRoom(
    req: Req.fromJson(json["req"]),
    players: List<dynamic>.from(json["players"].map((x) => x)),
    banList: List<dynamic>.from(json["banList"].map((x) => x)),
    status: json["status"],
    type: json["type"],
    turn: json["turn"],
    disconnectCount: json["disconnectCount"],
    id: json["_id"],
    roomName: json["roomName"],
    roomMaster: json["roomMaster"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "req": req.toJson(),
    "players": List<dynamic>.from(players.map((x) => x)),
    "banList": List<dynamic>.from(banList.map((x) => x)),
    "status": status,
    "type": type,
    "turn": turn,
    "disconnectCount": disconnectCount,
    "_id": id,
    "roomName": roomName,
    "roomMaster": roomMaster,
    "__v": v,
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
