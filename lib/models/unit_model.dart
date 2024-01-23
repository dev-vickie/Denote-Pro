import 'dart:convert';

class Unit {
  final String unitName;
  final String unitCode;
  String? lecturer;

  Unit({
    required this.unitName,
    required this.unitCode,
    required this.lecturer,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitName': unitName,
      'unitCode': unitCode,
      'lecturer': lecturer,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      unitName: map['unitName'] as String,
      unitCode: map['unitCode'] as String,
      lecturer: map['lecturer'] != null ? map['lecturer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source) as Map<String, dynamic>);
}
