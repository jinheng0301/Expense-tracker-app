import 'package:track_your_expenses/src/models/categories.dart';
import 'package:track_your_expenses/src/models/expense.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  Future<void> createExpense(Expense expense);

  Future<List<Expense>> getExpense();
}
