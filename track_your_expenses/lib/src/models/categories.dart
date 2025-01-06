import 'package:track_your_expenses/src/entities/category_entity.dart';

class Category {
  late String categoryId;
  late String name;
  late int totalExpenses;
  late String icon;
  late String color;

  Category({
    required this.categoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });
}

final empty = Category(
  categoryId: '',
  name: '',
  totalExpenses: 0,
  icon: '',
  color: '',
);

CategoryEntity toEntity(Category category) {
  return CategoryEntity(
    categoryId: category.categoryId,
    name: category.name,
    totalExpenses: category.totalExpenses,
    icon: category.icon,
    color: category.color,
  );
}

Category fromEntity(CategoryEntity entity) {
  return Category(
    categoryId: entity.categoryId,
    name: entity.name,
    totalExpenses: entity.totalExpenses,
    icon: entity.icon,
    color: entity.color,
  );
}