import 'package:denote_pro/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/unit_model.dart';

class AddUnit extends ConsumerStatefulWidget {
  const AddUnit({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddUnitState();
}

class _AddUnitState extends ConsumerState<AddUnit> {
  //text editing controllers
  final TextEditingController _unitNameController = TextEditingController();
  final TextEditingController _unitCodeController = TextEditingController();
  final TextEditingController _lecNameController = TextEditingController();

  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    //dispose text editing controllers
    _unitNameController.dispose();
    _unitCodeController.dispose();
    _lecNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Unit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                //
                TextFormField(
                  controller: _unitNameController,
                  decoration: InputDecoration(
                    labelText: "Unit Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    labelStyle: TextStyles.normal(20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Unit name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _unitCodeController,
                  decoration: InputDecoration(
                    labelText: "Unit Code",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    labelStyle: TextStyles.normal(20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Unit code cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _lecNameController,
                  decoration: InputDecoration(
                    labelText: "Lecturer's Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    labelStyle: TextStyles.normal(20),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lecturer name cannot be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                //submit button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final unit = Unit(
                        unitName: _unitNameController.text,
                        unitCode: _unitCodeController.text,
                        lecturer: _lecNameController.text,
                      );
                      print(unit.toMap());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Unit",
                    style: TextStyles.normal(20).copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
