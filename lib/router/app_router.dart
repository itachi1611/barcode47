import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/ui/home/home_page.dart';
import 'package:myapp/ui/main_shell.dart';
import 'package:myapp/ui/setting/setting_page.dart';
import 'package:myapp/ui/splash_page.dart';
import 'package:myapp/ui/view/view_page.dart';

// Giả định bạn sẽ có một trang Profile
// import 'package:myapp/ui/profile/profile_page.dart';

import 'navigator_observer.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: Routers.root.routerPath,
    navigatorKey: _rootNavigatorKey,
    observers: [NavObserver()],
    redirect: (context, state) {
      // final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      // final loggingIn = state.matchedLocation == Routers.login.routerPath;

      // // Nếu người dùng chưa đăng nhập và không ở trang đăng nhập -> chuyển đến trang đăng nhập
      // if (!isLoggedIn && !loggingIn) {
      //   return Routers.login.routerPath;
      // }

      // // Nếu người dùng đã đăng nhập và đang ở trang đăng nhập -> chuyển đến trang chủ
      // if (isLoggedIn && loggingIn) {
      //   return Routers.home.routerPath;
      // }

      return null; // không chuyển hướng
    },
    routes: [
      GoRoute(
        name: Routers.root.routerName,
        path: Routers.root.routerPath,
        builder: (context, state) => const SplashPage(),
      ),

      // Cấu trúc ShellRoute của bạn được giữ nguyên và cập nhật
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // MainShell đóng vai trò là UI chung (với BottomNavBar)
          return MainShell(child: navigationShell);
        },
        branches: [
          // Branch cho Tab Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routers.home.routerName,
                path: Routers.home.routerPath,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          // Branch cho Tab View
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routers.view.routerName,
                path: Routers.view.routerPath,
                builder: (context, state) => const ViewPage(),
              ),
            ],
          ),

          // Branch cho Tab Setting
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routers.setting.routerName,
                path: Routers.setting.routerPath,
                builder: (context, state) => const SettingPage(),
              ),
            ],
          ),

          // Branch cho Tab Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routers.profile.routerName,
                path: Routers.profile.routerPath,
                builder: (context, state) =>
                    const Center(child: Text("Profile Page")),
              ),
            ],
          ),
        ],
      ),

      // Các route khác không nằm trong Shell có thể được định nghĩa ở đây
      // ví dụ: một trang chi tiết được mở từ trang home
    ],
    errorBuilder: (context, state) =>
        Center(child: Text("Page not found: ${state.error}")),
  );
}
