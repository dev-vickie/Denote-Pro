// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:denote_pro/models/book_model.dart';

class UnitModel {
  final String unitId;
  final String unitName;
  final String unitCode;
  String? lecturer;
  final List<Book> books;
  final String updatedAt;


  UnitModel({
    required this.unitId,
    required this.unitName,
    required this.unitCode,
    required this.lecturer,
    required this.books,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitId': unitId,
      'unitName': unitName,
      'unitCode': unitCode,
      'lecturer': lecturer,
      'books': books.map((x) => x.toMap()).toList(),
      'updatedAt': updatedAt,
    };
  }

  factory UnitModel.fromMap(Map<String, dynamic> map) {
    return UnitModel(
      unitId: map['unitId'] as String,
      unitName: map['unitName'] as String,
      unitCode: map['unitCode'] as String,
      lecturer: map['lecturer'] != null ? map['lecturer'] as String : null,
      books: List<Book>.from(
        (map['books'] as List).map<Book>(
          (x) => Book.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnitModel.fromJson(String source) =>
      UnitModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UnitModel copyWith({
    String? unitId,
    String? unitName,
    String? unitCode,
    String? lecturer,
    List<Book>? books,
    String? updatedAt,
  }) {
    return UnitModel(
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      unitCode: unitCode ?? this.unitCode,
      lecturer: lecturer ?? this.lecturer,
      books: books ?? this.books,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
