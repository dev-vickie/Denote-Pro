import 'package:denote_pro/features/classes_and_units/screens/view_all_units.dart';
import 'package:denote_pro/features/home/screens/home.dart';
import 'package:denote_pro/theme/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

import 'screens/settings.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final pageControlller = PageController();
  @override
  void dispose() {
    pageControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider)!;
    return Scaffold(
      body: PageView(
        controller: pageControlller,
        children: const <Widget>[
          Home(),
          ViewAllUnits(),
          SettingsPage(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        activeItemColor: AppTheme.whiteColor,
        itemColor: AppTheme.whiteColor,
        color: AppTheme.secondaryColor,
        controller: pageControlller,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home_rounded,
              label: 'Home', activeColor: AppTheme.whiteColor),
          RollingBottomBarItem(Icons.library_books_outlined,
              label: 'Units', activeColor: AppTheme.whiteColor),
          RollingBottomBarItem(Icons.settings_rounded,
              label: 'Settings', activeColor: AppTheme.whiteColor),
        ],
        enableIconRotation: true,
        onTap: (index) {
          pageControlller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
