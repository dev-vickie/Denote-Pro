import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denote_pro/models/book_model.dart';
import 'package:denote_pro/models/failure.dart';
import 'package:denote_pro/models/unit_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
//provider
final unitsAndClassesRepoProvider = Provider<UnitsAndClassesRepository>((ref) {
  return UnitsAndClassesRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  );
});

class UnitsAndClassesRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  UnitsAndClassesRepository(
      {required FirebaseFirestore firebaseFirestore,
      required FirebaseStorage firebaseStorage})
      : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage;

  //create unit
  FutureEither<UnitModel> createUnit({required UnitModel unit}) async {
    try {
      final unitRef = _firebaseFirestore.collection("units").doc().id;
      final newUnit = unit.copyWith(unitId: unitRef);
      await _firebaseFirestore
          .collection("units")
          .doc(unitRef)
          .set(newUnit.toMap());
      return right(newUnit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //get all units stream
  Stream<List<UnitModel>> getAllUnits() {
    return _firebaseFirestore.collection("units").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UnitModel.fromMap(doc.data())).toList();
    });
  }

//function that saves the file to firebase storage,gets the link,then saves the link to firestore
  FutureEither<String> uploadPDFAndSaveDetails({
    required String uploadedBy,
    required UnitModel unit,
    required File pdfFile,
  }) async {
    try {
      // Upload the PDF file to Firebase Storage
      final storageRef = _firebaseStorage
          .ref()
          .child('pdfs/${unit.unitId}/${pdfFile.path.split('/').last}');
      final uploadTask = storageRef.putFile(pdfFile);
      final uploadTaskSnapshot = await uploadTask.whenComplete(() {});
      final pdfUrl = await uploadTaskSnapshot.ref.getDownloadURL();

      //create a new book instance
      final book = Book(
        uid: "",
        name: pdfFile.path.split('/').last,
        dateAdded: DateTime.now().toString(),
        unitId: unit.unitId,
        path: pdfUrl,
        addedBy: uploadedBy,
      );
      //create a firestore reference for the book
      final bookRef = _firebaseFirestore.collection("books").doc();
      final newBook = book.copyWith(uid: bookRef.id);
      //add book to the unit's books array in firestore
      await _firebaseFirestore.collection("units").doc(unit.unitId).update({
        "books": FieldValue.arrayUnion([newBook.toMap()])
      });

      return right("Book added successfully");
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //get all books in a unit - stream
  Stream<List<Book>> getBooksInUnit({required String unitId}) {
    return _firebaseFirestore
        .collection("units")
        .doc(unitId)
        .snapshots()
        .map((snapshot) {
      final unit = UnitModel.fromMap(snapshot.data()!);
      return unit.books;
    });
  }
}
