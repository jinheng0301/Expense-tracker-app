import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/src/models/categories.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  Future<void> createCategory(Category category) async {
    try {
      // Code to create a category in Firebase
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  Future<List<Category>> getCategory() async {
    try {
      // Code to create a category in Firebase
      return categoryCollection.get().then(
            (value) => value.docs
                .map(
                  (e) => Category.fromEntity(
                    CategoryEntity.fromDocument(
                      e.data(),
                    ),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }
}
