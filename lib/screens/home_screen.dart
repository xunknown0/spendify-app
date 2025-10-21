import 'package:flutter/material.dart';
import 'package:spendify/models/expense.dart';
import 'package:spendify/widgets/expense_list.dart';
import 'package:spendify/widgets/expense_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  //Dummy Data
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Chicken Joy',
        amount: 29.99,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'Bus',
        amount: 29.99,
        date: DateTime.now(),
        category: Category.transport),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const ExpenseForm());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spendify Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          //Toolbar with add button
          const Text('The Chart'),
          Expanded(child: ExpenseList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}
