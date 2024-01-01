import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Wonderful sessions"),
      ),
      body: Center(
        child: Text(
          "Home is the best place to be I dont get fraustrated giving all I have not\n ${user.name}",
          style: TextStyles.bold(20),
        ),
      ),
    );
  }
}
