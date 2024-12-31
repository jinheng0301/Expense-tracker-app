import 'package:flutter/material.dart';
import 'package:track_your_expenses/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: Color(0xFF00B2E7),
          secondary: Color(0xFFE064E7),
          tertiary: Color(0xFFFF806C),
          outline: Colors.grey.shade400,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
