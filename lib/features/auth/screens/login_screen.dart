import 'package:denote_pro/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../core/common/loader.dart';
import '../../../core/common/sign_in_button.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromARGB(255, 9, 53, 121),
                    Colors.blue[900]!,
                    Colors.blue[300]!,
                    Colors.blue[200]!,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Your all round student assistant",
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset(
                      Constants.bulbLottie,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  const SizedBox(),
                  const SignInButton(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  )
                ],
              ),
            ),
    );
  }
}
