import 'package:denote_pro/theme/textstyles.dart';
import 'package:denote_pro/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth/controllers/auth_controller.dart';

class Home extends ConsumerWidget {
  const Home({super.key});
  String greeting({required String username}) {
    final name = username.split(" ")[0];
    final hour = DateTime.now().hour;
    //morning 12am - 12pm
    if (hour >= 0 && hour < 12) {
      return "Good Morning\n$name";
    }
    //afternoon 12pm - 4pm
    if (hour >= 12 && hour < 16) {
      return "Good Afternoon\n$name";
    }
    //evening 4pm - 12am
    if (hour >= 16 && hour < 24) {
      return "Good Evening\n$name";
    }
    return "Hello $name";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 60),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    greeting(username: user.name),
                    style: TextStyles.bold(25),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(user.profilePic),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/dashboardTile.svg",
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to Denote",
                              style: TextStyles.bold(20).copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "You have not selected any class.Select a class to start viewing your notifications",
                              style: TextStyles.normal(15).copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select Class",
                                    style: TextStyles.normal(16).copyWith(
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.arrow_right_alt_rounded,
                                      color: AppTheme.primaryColor, size: 30),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Your Units",
                    style: TextStyles.bold(20),
                  ),
                  const Spacer(),
                  Text(
                    "View All",
                    style: TextStyles.normal(16).copyWith(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              // list of units,but not scrollable
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: const Image(
                        image: AssetImage(
                          "assets/icons/icunit.png",
                        ),
                        height: 50,
                      ),
                      title: const Text("Unit Name"),
                      subtitle: const Text("Unit Description"),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}