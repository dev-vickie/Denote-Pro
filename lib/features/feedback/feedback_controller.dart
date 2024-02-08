import 'package:denote_pro/features/feedback/feedback_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//state notifier provider
final feedbackControllerProvider =
    StateNotifierProvider<FeedbackController, bool>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return FeedbackController(feedbackRepository: feedbackRepository);
});

class FeedbackController extends StateNotifier<bool> {
  final FeedbackRepository _feedbackRepository;

  FeedbackController({required FeedbackRepository feedbackRepository})
      : _feedbackRepository = feedbackRepository,
        super(false);

  Future<void> sendFeedback({
    required String feedback,
    required String userId,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _feedbackRepository.sendFeedback(
      feedback: feedback,
      userId: userId,
    );
    res.fold(
      (l) {
        state = false;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(l.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              )
            ],
          ),
        );
      },
      (r) {
        state = false;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: Text(r),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      },
    );
  }
}
