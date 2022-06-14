import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].value;
          }
        }
        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum,
        };
      },
    );
  }

  double get _weekTotalValue {
    return groupedTransactionValues.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactionValues;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map(
          (tr) {
            return ChartBar(
              tr['day'] as String,
              tr['value'] as double,
              (tr['value'] as double) / _weekTotalValue,
            );
          },
        ).toList(),
      ),
    );
  }
}
