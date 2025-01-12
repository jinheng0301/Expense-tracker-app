import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/src/models/categories.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc
    extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final ExpenseRepository expenseRepository;

  CreateCategoryBloc(this.expenseRepository) : super(CreateCategoryInitial()) {
    on<CreateCategoryEvent>((event, emit) async {
      // TODO: implement event handler
      emit(CreateCategoryLoading());
      try {
        await expenseRepository.createCategory(event.category as Category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailure());
      }
    });
  }
}
