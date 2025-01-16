import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String uid;

  User({required this.username, required this.email, required this.uid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
    };
  }

  factory User.fromFirebaseSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
      username: data['username'],
      email: data['email'],
      uid: data['uid'],
    );
  }
}
