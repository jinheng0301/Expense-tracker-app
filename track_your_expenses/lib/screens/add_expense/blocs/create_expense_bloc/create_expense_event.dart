part of 'create_expense_bloc.dart';

abstract class CreateExpenseEvent {
  final Expense expense;

  CreateExpenseEvent(this.expense);
}

class CreateExpense extends CreateExpenseEvent {
  CreateExpense(Expense expense) : super(expense);
}
