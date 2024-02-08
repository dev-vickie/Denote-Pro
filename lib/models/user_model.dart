// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isAuthenticated;
  final String? email;
  final String? course;
  final String? year;
  bool isAdmin = false;

  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isAuthenticated,
    required this.email,
    required this.course,
    required this.year,
    this.isAdmin = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isAuthenticated': isAuthenticated,
      'email': email,
      'course': course,
      'year': year,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      email: map['email'] != null ? map['email'] as String : null,
      course: map['course'] != null ? map['course'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isAuthenticated,
    String? email,
    String? course,
    String? year,
    bool? isAdmin,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      course: course ?? this.course,
      year: year ?? this.year,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
