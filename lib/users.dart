// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
  });

  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone": phone,
        "website": website,
      };
}

Future<List<User>> fetchUser() async {
  final response = await http.get(
    'https://jsonplaceholder.typicode.com/users',
  );
  List<User> users = new List();
  final List decodedData = json.decode(response.body);
  if (response.statusCode == 200) {
    decodedData.forEach((user) {
      final usertemporal = User.fromJson(user);
      users.add(usertemporal);
    });
    return users;
  } else {
    throw Exception('Failed to load user');
  }
}
