import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/generated/l10n.dart';

import '../router/routers.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(location),
        onTap: (index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.view_agenda),
            label: S.of(context).view,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).setting,
          ),
          // Thêm mục Profile
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Bạn có thể thêm bản dịch cho 'Profile' sau
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith(Routers.home.routerPath)) {
      return 0;
    } else if (location.startsWith(Routers.view.routerPath)) {
      return 1;
    } else if (location.startsWith(Routers.setting.routerPath)) {
      return 2;
    } else if (location.startsWith(Routers.profile.routerPath)) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(Routers.home.routerPath);
        break;
      case 1:
        context.go(Routers.view.routerPath);
        break;
      case 2:
        context.go(Routers.setting.routerPath);
        break;
      case 3:
        context.go(Routers.profile.routerPath);
        break;
    }
  }
}
