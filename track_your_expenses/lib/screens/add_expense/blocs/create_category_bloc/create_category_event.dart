part of 'create_category_bloc.dart';

@immutable
abstract class CreateCategoryEvent {
  final String category;

  CreateCategoryEvent(this.category);
}

class CreateCategory extends CreateCategoryEvent {
  final String category;

  CreateCategory(this.category) : super('');

  List<Object> get props => [category];
}
