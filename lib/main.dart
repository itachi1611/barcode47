import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/app_provider.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: context.watch<AppProvider>().locale,

      // Sử dụng lại cấu hình từ Flutter Intl
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        // Delegate cho Firebase UI (để dịch màn hình đăng nhập)
        FirebaseUILocalizations.delegate,

        // Delegate cho các chuỗi của riêng bạn (lớp S)
        S.delegate,

        // Các delegates mặc định của Flutter
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
