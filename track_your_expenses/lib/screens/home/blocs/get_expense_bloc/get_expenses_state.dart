part of 'get_expenses_bloc.dart';

@immutable
sealed class GetExpensesState {}

final class GetExpensesInitial extends GetExpensesState {}

final class GetExpensesFailure extends GetExpensesState {}

final class GetExpensesLoading extends GetExpensesState {}

final class GetExpensesSuccess extends GetExpensesState {
  late final List<Expense> expenses;

  GetExpensesSuccess(this.expenses);

  List<Object> get props => [expenses];
}
