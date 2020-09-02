import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); // subtract by index of 7 elements will give last 7 days
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print('day..... ${DateFormat.E().format(weekDay)} ..... $totalSum');

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get maxWeeklySpending {
    return groupedTransactions.fold(0.0, (totalWeekly, transaction) {
      return totalWeekly + transaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('groupedTransactions..... ${groupedTransactions.toString()}');

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Row(
            children: groupedTransactions.map((tx) {
          return ChartBar(
              label: tx['day'],
              amount: tx['amount'],
              totalShare: maxWeeklySpending == 0.0
                  ? 0.0
                  : (tx['amount'] as double) / maxWeeklySpending);
        }).toList()),
      ),
    );
  }
}
