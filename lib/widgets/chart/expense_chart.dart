import 'package:flutter/material.dart';
import 'package:spendify/models/expense.dart';
import 'package:spendify/widgets/chart/expense_chart_bar.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key, required this.expenses});

  final List<Expense> expenses;

  // 🧮 Create buckets per category
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.bill),
      ExpenseBucket.forCategory(expenses, Category.entertainment),
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.rent),
      ExpenseBucket.forCategory(expenses, Category.transport),
    ];
  }

  // 🔢 Compute max total to normalize chart height
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(isDarkMode ? 0.15 : 0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          // 🟦 Chart bars
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (final bucket in buckets)
                  ExpenseChartBar(
                    fill: maxTotalExpense == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 🏷️ Category icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buckets.map((bucket) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    categoryIcons[bucket.category],
                    color: isDarkMode
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
