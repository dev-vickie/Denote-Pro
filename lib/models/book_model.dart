// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  final String uid;
  final String name;
  final String dateAdded;
  final String unitId;
  final String path;
  final String addedBy;

  Book({
    required this.uid,
    required this.name,
    required this.dateAdded,
    required this.unitId,
    required this.path,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'dateAdded': dateAdded,
      'unitId': unitId,
      'path': path,
      'addedBy': addedBy,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      uid: map['uid'] as String,
      name: map['name'] as String,
      dateAdded: map['dateAdded'] as String,
      unitId: map['unitId'] as String,
      path: map['path'] as String,
      addedBy: map['addedBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);

  Book copyWith({
    String? uid,
    String? name,
    String? dateAdded,
    String? unitId,
    String? path,
    String? addedBy,
  }) {
    return Book(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      dateAdded: dateAdded ?? this.dateAdded,
      unitId: unitId ?? this.unitId,
      path: path ?? this.path,
      addedBy: addedBy ?? this.addedBy,
    );
  }
}
