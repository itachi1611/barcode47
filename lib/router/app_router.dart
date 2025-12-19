import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/home/home_page.dart';
import '../ui/main_shell.dart';
import '../ui/setting/setting_page.dart';
import '../ui/splash_page.dart';
import '../ui/view/view_page.dart';
import 'routers.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routers.root.routerPath,
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final loggingIn = state.matchedLocation == Routers.login.routerPath;

    // Nếu người dùng chưa đăng nhập và không ở trang đăng nhập -> chuyển đến trang đăng nhập
    if (!isLoggedIn && !loggingIn) {
      return Routers.login.routerPath;
    }

    // Nếu người dùng đã đăng nhập và đang ở trang đăng nhập -> chuyển đến trang chủ
    if (isLoggedIn && loggingIn) {
      return Routers.home.routerPath;
    }

    return null; // không chuyển hướng
  },
  routes: [
    GoRoute(
      name: Routers.root.routerName,
      path: Routers.root.routerPath,
      builder: (context, state) => const SplashPage(),
    ),
    // Thêm route cho màn hình đăng nhập
    GoRoute(
      name: Routers.login.routerName,
      path: Routers.login.routerPath,
      builder: (context, state) {
        return SignInScreen(
          providers: [EmailAuthProvider()],
          actions: [
            ForgotPasswordAction((context, email) {
              final uri = Uri(
                path: '${Routers.login.routerPath}/forgotPassword',
                queryParameters: <String, String?>{'email': email},
              );
              context.push(uri.toString());
            }),
          ],
        );
      },
      routes: [
        GoRoute(
          path: Routers.forgotPassword.routerPath,
          name: Routers.forgotPassword.routerName,
          builder: (context, state) {
            final arguments = state.uri.queryParameters;
            return ForgotPasswordScreen(
              email: arguments['email'],
              headerMaxExtent: 200,
            );
          },
        ),
      ],
    ),
    // Thêm route cho màn hình hồ sơ người dùng
    GoRoute(
      name: Routers.profile.routerName,
      path: Routers.profile.routerPath,
      builder: (context, state) {
        return ProfileScreen(
          providers: [EmailAuthProvider()],
          actions: [
            SignedOutAction((context) {
              context.go(Routers.login.routerPath);
            }),
          ],
        );
      },
    ),
    // Các route hiện tại của bạn được giữ nguyên
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routers.home.routerName,
              path: Routers.home.routerPath,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routers.view.routerName,
              path: Routers.view.routerPath,
              builder: (context, state) => const ViewPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: Routers.setting.routerName,
              path: Routers.setting.routerPath,
              builder: (context, state) => const SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
