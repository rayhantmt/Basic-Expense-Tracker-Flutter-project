import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/enum.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  void _onpressedAction() {
    showModalBottomSheet(
      useSafeArea: true,// this makes the camera space or other upper padding proper
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddexpense: addexpense,
      ),
    );
  }

  final List<Expenselist> _registeredexpenses = [
    Expenselist(
        categary: Categary.food,
        amount: 18.55,
        dateTime: DateTime.now(),
        title: 'Snacks'),
    Expenselist(
        categary: Categary.living,
        amount: 40.50,
        dateTime: DateTime.now(),
        title: 'Outside Dhaka')
  ];
  void addexpense(Expenselist expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
  }

  void removeexpense(Expenselist expense) {
    final indexof = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Expense Deleted Successfully!'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(
                () {
                  _registeredexpenses.insert(indexof, expense);
                },
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget constant = Center(
      child: Text('No expense found.Try adding some!'),
    );

    if (_registeredexpenses.isNotEmpty) {
      constant = Expensel(
        expenses: _registeredexpenses,
        remove: removeexpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker App'),
        actions: [
          IconButton(onPressed: _onpressedAction, icon: Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Expanded(child: Chart(expenses: _registeredexpenses)),
                Expanded(
                  child: constant,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredexpenses)) ,
                Expanded(
                  child: constant,
                ),
              ],
            ),
    );
  }
}
