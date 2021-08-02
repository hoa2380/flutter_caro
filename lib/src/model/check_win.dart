import 'dart:convert';

CheckWin checkWinFromJson(String str) => CheckWin.fromJson(json.decode(str));

String checkWinToJson(CheckWin data) => json.encode(data.toJson());

class CheckWin {
  CheckWin({
    this.checkWin,
    this.listMoves,
  });

  bool checkWin;
  List<ListMove> listMoves;

  factory CheckWin.fromJson(Map<String, dynamic> json) => CheckWin(
    checkWin: json["checkWin"],
    listMoves: List<ListMove>.from(json["listMoves"].map((x) => ListMove.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "checkWin": checkWin,
    "listMoves": List<dynamic>.from(listMoves.map((x) => x.toJson())),
  };
}

class ListMove {
  ListMove({
    this.id,
    this.x,
    this.y,
    this.player,
    this.room,
    this.v,
  });

  String id;
  int x;
  int y;
  String player;
  String room;
  int v;

  factory ListMove.fromJson(Map<String, dynamic> json) => ListMove(
    id: json["_id"],
    x: json["x"],
    y: json["y"],
    player: json["player"],
    room: json["room"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "x": x,
    "y": y,
    "player": player,
    "room": room,
    "__v": v,
  };
}
