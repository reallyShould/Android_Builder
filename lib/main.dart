import 'package:flutter/material.dart';
import 'main_page.dart';
import 'final_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC Builder',
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/final': (context) => FinalPage(),
      },
    );
  }
}
