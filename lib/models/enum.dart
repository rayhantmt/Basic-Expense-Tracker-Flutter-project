import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();
const categaryIcons = {
  Categary.food: Icons.lunch_dining,
  Categary.living: Icons.home,
  Categary.smoke: Icons.app_blocking_sharp,
  Categary.transport: Icons.flight
};

enum Categary { food, smoke, transport, living }

class Expenselist {
  Expenselist(
      {required this.categary,
      required this.amount,
      required this.dateTime,
      required this.title})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Categary categary;

  String get formattedDate => formatter.format(dateTime);
}

class ExpenseBucket {
  //new class for handling the data of the chart
  ExpenseBucket(
      {required this.categary,
      required this.expenses}); //consructor function for expensebucket
  ExpenseBucket.forCategary(List<Expenselist> allexpenses,
      this.categary) // another consructor function for extra
      : expenses = allexpenses
            .where((expense) => expense.categary == categary)
            .toList(); // tuff topic skiped for later;
  final Categary categary; //category is required for different category
  final List<Expenselist> expenses; // expenselist is required for all data

  double get totalExpenses {
    //getter method for summing up the amount
    double sum = 0; //a variable to store the summed up amount
    for (final expense in expenses) {
      //for in loop
      sum +=
          expense.amount; // method to sum up the amounts using the for in loop
    }
    return sum; // returning the summed up amount
  }
}
