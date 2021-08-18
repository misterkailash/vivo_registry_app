// To parse this JSON data, do
//  final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.success,
    required this.token,
    required this.user,
    required this.imgPath,
  });

  bool success;
  Token token;
  UserClass user;
  String imgPath;

  factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        token: Token.fromJson(json["token"]),
        user: UserClass.fromJson(json["user"]),
        imgPath: json["imgPath"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token.toJson(),
        "user": user.toJson(),
        "imgPath": imgPath,
      };
}

class Token {
  Token({
    required this.token,
  });

  String token;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.name,
    required this.empId,
    required this.email,
    required this.providerId,
    required this.emailVerifiedAt,
    required this.profilePath,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String empId;
  String email;
  dynamic providerId;
  dynamic emailVerifiedAt;
  String profilePath;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        empId: json["empID"],
        email: json["email"],
        providerId: json["provider_id"],
        emailVerifiedAt: json["email_verified_at"],
        profilePath: json["profile_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "empID": empId,
        "email": email,
        "provider_id": providerId,
        "email_verified_at": emailVerifiedAt,
        "profile_path": profilePath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
