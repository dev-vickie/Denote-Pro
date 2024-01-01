import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/features/auth/screens/login_screen.dart';
import 'package:denote_pro/features/home/home_page.dart';
import 'package:denote_pro/firebase_options.dart';
import 'package:denote_pro/models/user_model.dart';
import 'package:denote_pro/theme/theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/common/error_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final  scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      title: 'Denote',
      theme: AppTheme.lightTheme,
      home: ref.watch(authStateChangeProvider).when(
            data: (data) {
              if (data != null) {
                getData(ref, data);
                if (userModel != null) {
                  return const Homepage();
                }
              }
              return const LoginScreen();
            },
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const ErrorPage(),
          ),
    );
  }
}
