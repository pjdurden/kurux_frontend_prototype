import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/login_page.dart';

import 'Other_Pages/initialLoadingScreen.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KuruX',
      theme: ThemeData.dark(),
      initialRoute: '/terms_cond',
      routes: <String, WidgetBuilder>{
        '/terms_cond': (context) => const initialLoadingScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) =>
            const MyHomePage(title: 'KuruX Funding Portal', user_id: 'KuruX')
      },
      // Use initial route for disclaimer
      // initialRoute: '/login',
      // onGenerateInitialRoutes: (route) {
      //   return [
      //     MaterialPageRoute(
      //         builder: (_) => const LoginPage(title: 'KuruX Funding Portal'))
      //   ];
      // },
      home: const LoginPage(),
    );
  }
}
