// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String profilPic;
  final String uid;
  final String token;
  UserModel({
    required this.email,
    required this.name,
    required this.profilPic,
    required this.uid,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'profilPic': profilPic,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      profilPic: map['profilPic'] as String,
      uid: map['_id'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? email,
    String? name,
    String? profilPic,
    String? uid,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilPic: profilPic ?? this.profilPic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
