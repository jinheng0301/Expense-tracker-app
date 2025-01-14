part of 'get_categories_bloc.dart';

@immutable
sealed class GetCategoriesState {}

final class GetCategoriesInitial extends GetCategoriesState {}

final class GetCategoriesFailure extends GetCategoriesState {}

final class GetCategoriesLoading extends GetCategoriesState {}

final class GetCategoriesSuccess extends GetCategoriesState {
  late final List<Category> categories;

  GetCategoriesSuccess({required this.categories});

  List<Object> get props => [categories];
}
