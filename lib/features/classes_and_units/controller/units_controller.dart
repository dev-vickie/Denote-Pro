import 'dart:io';

import 'package:denote_pro/core/utils.dart';
import 'package:denote_pro/models/book_model.dart';
import 'package:denote_pro/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/units_and_classes_repository.dart';

//state notifier provider
final unitsControllerProvider =
    StateNotifierProvider<UnitsController, bool>((ref) {
  final unitsAndClassesRepository = ref.watch(unitsAndClassesRepoProvider);
  return UnitsController(unitsAndClassesRepository: unitsAndClassesRepository);
});

//stream provider for units
final allUnitsStreamProvider =
    StreamProvider.autoDispose<List<UnitModel>>((ref) {
  final unitsController = ref.watch(unitsControllerProvider.notifier);
  return unitsController.getUnits();
});

//stream provider for files in a unit
final booksInAUnitStreamProvider =
    StreamProvider.autoDispose.family<List<Book>, String>((ref, unitId) {
  final unitsController = ref.watch(unitsControllerProvider.notifier);
  return unitsController.getFiles(unitId: unitId);
});

class UnitsController extends StateNotifier<bool> {
  final UnitsAndClassesRepository _unitsAndClassesRepository;

  UnitsController(
      {required UnitsAndClassesRepository unitsAndClassesRepository})
      : _unitsAndClassesRepository = unitsAndClassesRepository,
        super(false);

  //create unit
  Future<void> createUnit({
    required UnitModel unit,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _unitsAndClassesRepository.createUnit(unit: unit);

    res.fold((l) {
      state = false;
      print(l);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, "${r.unitName} added successfully");
      Navigator.pop(context);
    });
  }

  //get units stream
  Stream<List<UnitModel>> getUnits() {
    return _unitsAndClassesRepository.getAllUnits();
  }

  //upload pdf and save details
  Future<void> uploadPDFAndSaveDetails({
    required String uploadedBy,
    required UnitModel unit,
    required File pdfFile,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _unitsAndClassesRepository.uploadPDFAndSaveDetails(
      uploadedBy: uploadedBy,
      unit: unit,
      pdfFile: pdfFile,
    );

    res.fold((l) {
      state = false;
      print(l);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      showSnackBar(context, "File uploaded successfully");
      Navigator.pop(context);
    });
  }

  //get all files in a unit
  Stream<List<Book>> getFiles({required String unitId}) {
    return _unitsAndClassesRepository.getBooksInUnit(unitId: unitId);
  }

  //delete a book
  Future<void> deleteBook({
    required Book book,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _unitsAndClassesRepository.deleteBook(
      book: book,
    );
    res.fold((l) {
      state = false;
      print(l);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      Navigator.pop(context);
      showSnackBar(context, "File deleted successfully");
    });
  }

  //delete a unit
  Future<void> deleteUnit({
    required UnitModel unit,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _unitsAndClassesRepository.deleteUnit(
      unit: unit,
    );
    res.fold((l) {
      state = false;
      print(l);
      showSnackBar(context, l.message);
    }, (r) {
      state = false;
      Navigator.pop(context);
      showSnackBar(context, "Unit deleted successfully");
    });
  }
}
