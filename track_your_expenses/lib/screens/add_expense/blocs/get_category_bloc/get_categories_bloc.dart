import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/src/models/categories.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesState, GetCategoriesState> {
  ExpenseRepository expenseRepository;

  GetCategoriesBloc(this.expenseRepository) : super(GetCategoriesInitial()) {
    on<GetCategoriesState>((event, emit) async {
      // TODO: implement event handler
      emit(GetCategoriesLoading());
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategoriesSuccess(categories: categories));
      } catch (e) {
        emit(GetCategoriesFailure());
        throw {e.toString()};
      }
    });
  }
}
