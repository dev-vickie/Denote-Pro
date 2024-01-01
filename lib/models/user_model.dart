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

  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isAuthenticated,
    required this.email,
    required this.course,
    required this.year,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isAuthenticated,
    String? email,
    String? course,
    String? year,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      email: email ?? this.email,
      course: course ?? this.course,
      year: year ?? this.year,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, profilePic: $profilePic, isAuthenticated: $isAuthenticated, email: $email, course: $course, year: $year)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.uid == uid &&
      other.profilePic == profilePic &&
      other.isAuthenticated == isAuthenticated &&
      other.email == email &&
      other.course == course &&
      other.year == year;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      uid.hashCode ^
      profilePic.hashCode ^
      isAuthenticated.hashCode ^
      email.hashCode ^
      course.hashCode ^
      year.hashCode;
  }
}
