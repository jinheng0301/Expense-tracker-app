import 'package:track_your_expenses/src/entities/expense_entity.dart';
import 'package:track_your_expenses/src/models/categories.dart';

class Expense {
  late String expenseId;
  late Category category;
  late DateTime date;
  int amount;

  Expense({
    required this.amount,
    required this.category,
    required this.date,
    required this.expenseId,
  });

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0, 
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      category: category,
      date: date,
      amount: amount, 
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      category: entity.category,
      date: entity.date,
      amount: entity.amount, 
    );
  }
}
