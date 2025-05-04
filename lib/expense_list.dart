import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/enum.dart';
import 'package:flutter/material.dart';

class Expensel extends StatelessWidget {
  const Expensel({super.key, required this.expenses, required this.remove});
  final List<Expenselist> expenses;
  final void Function(Expenselist expense) remove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: kColorScheme.error.withOpacity(0.5),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expenses[index]),
              child: ExpenseItem(expenses[index]),
              onDismissed: (direction) {
                remove(expenses[index]);
              },
            ));
  }
}
