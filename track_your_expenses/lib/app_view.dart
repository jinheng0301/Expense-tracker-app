import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_your_expenses/screens/home/blocs/get_expense_bloc/get_expenses_bloc.dart';
import 'package:track_your_expenses/screens/home/home_screen.dart';
import 'package:track_your_expenses/src/firebase_expense_repo.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color(0xFF00B2E7),
          secondary: const Color(0xFFE064E7),
          tertiary: const Color(0xFFFF806C),
          outline: Colors.grey.shade400,
        ),
      ),
      home: BlocProvider(
        create: (context) =>
            GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses()),
        child: const HomeScreen(),
      ),
    );
  }
}
