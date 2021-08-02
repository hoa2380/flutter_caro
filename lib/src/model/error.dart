class Error {
  Error({
    this.message,
    this.event,
  });

  String message;
  String event;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    message: json["message"],
    event: json["event"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "event": event,
  };
}
