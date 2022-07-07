// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class UserLoginModel {
  UserLoginModel({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  UserLoginModel copyWith({
    User? user,
    String? token,
  }) =>
      UserLoginModel(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory UserLoginModel.fromJson(String str) =>
      UserLoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLoginModel.fromMap(Map<String, dynamic> json) => UserLoginModel(
        user: User.fromMap(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
      };
}

class User {
  User({
    required this.name,
    required this.email,
    required this.img,
    required this.rol,
    required this.status,
    required this.datetime,
    required this.uid,
  });

  String name;
  String email;
  String img;
  String rol;
  bool status;
  String datetime;
  String uid;

  User copyWith({
    String? name,
    String? email,
    String? img,
    String? rol,
    bool? status,
    String? datetime,
    String? uid,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        img: img ?? this.img,
        rol: rol ?? this.rol,
        status: status ?? this.status,
        datetime: datetime ?? this.datetime,
        uid: uid ?? this.uid,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        img: json["img"],
        rol: json["rol"],
        status: json["status"],
        datetime: json["datetime"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "img": img,
        "rol": rol,
        "status": status,
        "datetime": datetime,
        "uid": uid,
      };
}
