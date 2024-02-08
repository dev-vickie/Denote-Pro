import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denote_pro/models/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

//feedback repository provider
final feedbackRepositoryProvider = Provider<FeedbackRepository>((ref) {
  final firestore =  FirebaseFirestore.instance; 
  return FeedbackRepository(firebaseFirestore: firestore);
});

class FeedbackRepository {
  final FirebaseFirestore _firebaseFirestore;

  FeedbackRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  //send feedback
  FutureEither<String> sendFeedback({
    required String feedback,
    required String userId,
  }) async {
    try {
      await _firebaseFirestore.collection('feedback').add({
        'feedback': feedback,
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return right('Feedback sent successfully');
    } catch (e) {
      return left(Failure('Failed to send feedback'));
    }
  }
}
