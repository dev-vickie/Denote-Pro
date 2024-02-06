import 'package:denote_pro/core/common/loader.dart';
import 'package:denote_pro/features/classes_and_units/controller/units_controller.dart';
import 'package:denote_pro/features/home/widgets/home_unit_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewAllUnits extends ConsumerWidget {
  const ViewAllUnits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Units'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ref.watch(allUnitsStreamProvider).when(
              data: (units) {
                return ListView.builder(
                  itemCount: units.length,
                  itemBuilder: (context, index) {
                    final unit = units[index];
                    return HomeUnitTile(unit: unit);
                  },
                );
              },
              error: (error, stackTrace) {
                print("Error: $error");
                return const Center(
                  child: Text(
                    "Something went wrong while fetching units",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
