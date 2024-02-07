import 'package:denote_pro/features/auth/controllers/auth_controller.dart';
import 'package:denote_pro/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feedback.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Text("Help",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text(
                "Feedback/Feature Request",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FeedbackPage(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(Icons.pending_actions_outlined),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text(
                "Contact Developer",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            tileColor: Colors.grey[300],
                            leading: const Icon(
                              Icons.email_outlined,
                              size: 30,
                              color: AppTheme.primaryColor,
                            ),
                            title: const Text(
                              "Send An Email",
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            onTap: () async {
                              final Email email = Email(
                                subject: 'Denote Pro Feedback/Feature Request',
                                recipients: ['vmutethia84@gmail.com'],
                                isHTML: false,
                              );

                              await FlutterEmailSender.send(email);
                            },
                            subtitle: const Text("vmutethia84@gmail.com"),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            tileColor: Colors.grey[300],
                            leading: const Icon(
                              Icons.telegram_outlined,
                              size: 30,
                              color: AppTheme.primaryColor,
                            ),
                            title: const Text(
                              "WhatsApp Me",
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            onTap: () {
                              //open whatsapp
                            },
                            subtitle: const Text("+254 713601982"),
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            tileColor: Colors.grey[300],
                            leading: const Icon(
                              Icons.code_outlined,
                              size: 30,
                              color: AppTheme.primaryColor,
                            ),
                            title: const Text(
                              "View Source Code",
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            onTap: () async {
                              final uri = Uri.parse(
                                  "https://github.com/dev-vickie/Denote-Pro");
                              await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            subtitle: const Text("GitHub"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              trailing: const Icon(Icons.pending_actions_outlined),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: Colors.grey[300],
              title: const Text(
                "Sign Out",
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
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
