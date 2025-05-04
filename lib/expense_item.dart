import 'package:expense_tracker/models/enum.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenses, {super.key});
  final Expenselist expenses;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenses.title, style: Theme.of(context).textTheme.titleLarge,),
            Row(
              children: [
                Text("\$${expenses.amount}"),
                Spacer(),
                Row(
                  children: [
                    Icon(categaryIcons[expenses.categary]),
                    Text(expenses.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
