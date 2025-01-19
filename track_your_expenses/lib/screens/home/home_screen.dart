import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:track_your_expenses/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:track_your_expenses/screens/add_expense/blocs/get_category_bloc/get_categories_bloc.dart';
import 'package:track_your_expenses/screens/add_expense/views/add_expense.dart';
import 'package:track_your_expenses/screens/home/blocs/get_expense_bloc/get_expenses_bloc.dart';
import 'package:track_your_expenses/screens/home/views/main_screen.dart';
import 'package:track_your_expenses/screens/home/views/stat_screen.dart';
import 'package:track_your_expenses/src/models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          var appScreen = [
            MainScreen(expenses: state.expenses),
            const StatScreen(),
          ];

          Scaffold(
            body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: appScreen,
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.grey.shade300,
                onTap: navigationTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.home,
                      color: _page == 0
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.graph_square_fill,
                      color: _page == 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                    ),
                    label: 'Stats',
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () async {
                var newExpense = await Navigator.push(
                  context,
                  MaterialPageRoute<Expense>(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => CreateCategoryBloc(
                            FirebaseExpenseRepo(),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => GetCategoriesBloc(
                            FirebaseExpenseRepo(),
                          ),
                        ),
                        BlocProvider(
                          create: (context) => CreateExpenseBloc(
                            FirebaseExpenseRepo(),
                          ),
                        ),
                      ],
                      child: const AddExpense(),
                    ),
                  ),
                );

                newExpense != null
                    ? setState(() {
                        state.expenses.add(newExpense);
                      })
                    : null;
              },
              child: Container(
                width: width * 0.15,
                height: height * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.tertiary,
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.add,
                ),
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const Scaffold(
          // body: Center(
          //   child: CircularProgressIndicator(),
          // ),
        );
      },
    );
  }
}
