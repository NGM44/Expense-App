import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/models/transaction.dart';
import 'package:money/widgets/chartBar.dart';

class ChartView extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const ChartView({@required this.recentTransactions});

  List<Map<String, Object>> get groupedValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: chartBar(
                  data['day'],
                  data['amount'],
                  maxSpending == 0.0 ? 0.0 : (data['amount'] as double) / maxSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
