import 'dart:convert';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? nationalCode;
  String? phone;

  //String image;

  User(
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.nationalCode,
    this.username,
    this.phone,
    //this.image
  );

  factory User.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return User(
      jsonMapObject['id'],
      jsonMapObject['firstName'],
      jsonMapObject['lastName'],
      jsonMapObject['email'],
      jsonMapObject['username'],
      jsonMapObject['nationalCode'],
      jsonMapObject['phone'],
      // jsonMapObject['image']
    );
  }
}
