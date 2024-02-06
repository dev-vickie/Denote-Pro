import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  //CircleAvatar with users profile pic,overlayed by a small edit icon on the bottom right
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(user.profilePic),
                        backgroundColor: Colors.transparent,
                      ),
                      // Positioned(
                      //   right: 0,
                      //   bottom: 0,
                      //   child: Icon(Icons.edit, size: 25),
                      // ),
                    ],
                  ),

                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text("Feedback/Feature Request",
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
              //rounded border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(Icons.pending_actions_outlined),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text("Contact Developer",
                  style: TextStyle(fontSize: 18)),
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
              //rounded border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(Icons.pending_actions_outlined),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text("Sign Out", style: TextStyle(fontSize: 18)),
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
              //rounded border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(Icons.pending_actions_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
