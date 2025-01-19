import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/src/models/expense.dart';

part 'create_expense_event.dart';
part 'create_expense_state.dart';

class CreateExpenseBloc extends Bloc<CreateExpenseEvent, CreateExpenseState> {
  ExpenseRepository expenseRepository;

  CreateExpenseBloc(this.expenseRepository) : super(CreateExpenseInitial()) {
    on<CreateExpenseEvent>((event, emit) async {
      emit(CreateExpenseLoading()); // TODO: implement event handler
      try {
        await expenseRepository.createExpense(event.expense);
        emit(CreateExpenseSuccess());
      } catch (e) {
        emit(CreateExpenseFailure());
      }
    });
  }
}
