import 'package:denote_pro/features/classes_and_units/screens/view_unit.dart';
import 'package:denote_pro/models/unit_model.dart';
import 'package:flutter/material.dart';

class HomeUnitTile extends StatelessWidget {
  final UnitModel unit;
  const HomeUnitTile({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          //navigate to unit details
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewUnit(unit: unit),
            ),
          );
        },
        tileColor: Colors.white,
        leading: const Image(
          image: AssetImage(
            "assets/icons/icunit.png",
          ),
          height: 50,
        ),
        title: Text(unit.unitName),
        subtitle: Text("${unit.books.length} files"),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
