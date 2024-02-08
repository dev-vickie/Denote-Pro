import 'package:denote_pro/features/classes_and_units/controller/units_controller.dart';
import 'package:denote_pro/features/classes_and_units/screens/view_unit.dart';
import 'package:denote_pro/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeUnitTile extends ConsumerWidget {
  final UnitModel unit;
  const HomeUnitTile({super.key, required this.unit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onLongPress: () {
          //show a dialog to delete the unit
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Delete Unit"),
                content:
                    const Text("Are you sure you want to delete this unit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(unitsControllerProvider.notifier).deleteUnit(
                            unit: unit,
                            context: context,
                          );
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
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
