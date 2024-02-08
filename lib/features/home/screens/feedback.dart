import 'package:denote_pro/core/common/loader.dart';
import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../feedback/feedback_controller.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  //text controller
  final TextEditingController _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(feedbackControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Feedback"),
        ),
        body: isLoading
            ? const Center(
                child: Loader(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "I would love to hear from you!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Your feedback is important to me. Please share your thoughts or suggest a feature you would like to see in the app.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _feedbackController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Type your feedback here...",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your feedback";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(feedbackControllerProvider.notifier)
                                .sendFeedback(
                                  feedback: _feedbackController.text,
                                  userId: ref.read(userProvider)!.uid,
                                  context: context,
                                );
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
                          "Submit",
                          style: TextStyles.normal(20).copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
