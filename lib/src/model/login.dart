class Login {
  Login({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.isExpired,
    this.isPendingUpdateCoin,
    this.id,
    this.timeLogin,
    this.lastestTimeRequest,
    this.user,
    this.token,
    this.accessToken,
    this.fcmToken,
    this.device,
    this.deviceId,
    this.v,
  });

  int isExpired;
  int isPendingUpdateCoin;
  String id;
  DateTime timeLogin;
  DateTime lastestTimeRequest;
  User user;
  String token;
  String accessToken;
  String fcmToken;
  int device;
  String deviceId;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    isExpired: json["isExpired"],
    isPendingUpdateCoin: json["isPendingUpdateCoin"],
    id: json["_id"],
    timeLogin: DateTime.parse(json["timeLogin"]),
    lastestTimeRequest: DateTime.parse(json["lastestTimeRequest"]),
    user: User.fromJson(json["user"]),
    token: json["token"],
    accessToken: json["accessToken"],
    fcmToken: json["fcmToken"],
    device: json["device"],
    deviceId: json["deviceId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "isExpired": isExpired,
    "isPendingUpdateCoin": isPendingUpdateCoin,
    "_id": id,
    "timeLogin": timeLogin.toIso8601String(),
    "lastestTimeRequest": lastestTimeRequest.toIso8601String(),
    "user": user.toJson(),
    "token": token,
    "accessToken": accessToken,
    "fcmToken": fcmToken,
    "device": device,
    "deviceId": deviceId,
    "__v": v,
  };
}

class User {
  User({
    this.gender,
    this.profilePicture,
    this.about,
    this.role,
    this.expiredAt,
    this.id,
    this.username,
    this.email,
    this.registerDate,
    this.listChild,
  });

  int gender;
  List<dynamic> profilePicture;
  String about;
  int role;
  dynamic expiredAt;
  String id;
  String username;
  String email;
  DateTime registerDate;
  List<dynamic> listChild;

  factory User.fromJson(Map<String, dynamic> json) => User(
    gender: json["gender"],
    profilePicture: List<dynamic>.from(json["profilePicture"].map((x) => x)),
    about: json["about"],
    role: json["role"],
    expiredAt: json["expiredAt"],
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    registerDate: DateTime.parse(json["registerDate"]),
    listChild: List<dynamic>.from(json["listChild"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "profilePicture": List<dynamic>.from(profilePicture.map((x) => x)),
    "about": about,
    "role": role,
    "expiredAt": expiredAt,
    "_id": id,
    "username": username,
    "email": email,
    "registerDate": registerDate.toIso8601String(),
    "listChild": List<dynamic>.from(listChild.map((x) => x)),
  };
}
