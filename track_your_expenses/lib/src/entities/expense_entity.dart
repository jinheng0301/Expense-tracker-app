import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_your_expenses/expense_repository.dart';
import 'package:track_your_expenses/src/models/categories.dart';

class ExpenseEntity {
  late String expenseId;
  late Category category;
  late DateTime date;
  int amount;

  ExpenseEntity({
    required this.amount,
    required this.category,
    required this.date,
    required this.expenseId,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
    };
  }

  static ExpenseEntity fromDocument(Map<String, Object?> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'] as String,
      category: Category.fromEntity(
        CategoryEntity.fromDocument(
          doc['category'] as Map<String, Object?>,
        ),
      ),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'] as int,
    );
  }
}
