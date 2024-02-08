import 'package:denote_pro/core/common/loader.dart';
import 'package:denote_pro/features/classes_and_units/controller/units_controller.dart';
import 'package:denote_pro/features/home/widgets/home_unit_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/textstyles.dart';
import '../../auth/controllers/auth_controller.dart';
import 'add_unit_screen.dart';

class ViewAllUnits extends ConsumerWidget {
  const ViewAllUnits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(unitsControllerProvider);
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Units'),
        actions: [
          user.isAdmin
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddUnit(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 40),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Loader(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ref.watch(allUnitsStreamProvider).when(
                    data: (units) {
                      if (units.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/icempty.png",
                                height: 100,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "No Units Found",
                                style: TextStyles.bold(20),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      }
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
