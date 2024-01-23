// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:denote_pro/models/unit_model.dart';

class Class {
  final String className;
  final String classId;
  final List<Unit> units;

  Class({
    required this.className,
    required this.classId,
    required this.units,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'className': className,
      'classId': classId,
      'units': units.map((x) => x.toMap()).toList(),
    };
  }

  factory Class.fromMap(Map<String, dynamic> map) {
    return Class(
      className: map['className'] as String,
      classId: map['classId'] as String,
      units: List<Unit>.from((map['units'] as List<int>).map<Unit>((x) => Unit.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Class.fromJson(String source) => Class.fromMap(json.decode(source) as Map<String, dynamic>);
}
