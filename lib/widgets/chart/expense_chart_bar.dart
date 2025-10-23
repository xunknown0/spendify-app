import 'package:flutter/material.dart';

class ExpenseChartBar extends StatelessWidget {
  const ExpenseChartBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.15), // background of the bar
          ),
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: fill.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
