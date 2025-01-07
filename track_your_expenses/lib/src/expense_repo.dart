import 'package:track_your_expenses/src/models/categories.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategory();
}
