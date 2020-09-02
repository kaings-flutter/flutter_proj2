import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:
            485, // you need to fix the height so that the scroll knows how hieght it can take!!!!!!

        // better way of implementing ListView is using ListView.builder. ListView.builder only renders items that are visible (good for performance)
        // normal ListView on another hand, renders ALL items regardless of visible or not (bad for performance when dealing with long list items)
        child: ListView.builder(
          itemBuilder: (buildCtx, idx) {
            // idx refers to index of the list items
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(5),
              child: ListTile(
                // alternative to row
                leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${transactions[idx].amount}'),
                      ),
                    )),
                title: Text(transactions[idx].title,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text(DateFormat.yMMMd().format(transactions[idx].date)),
              ),
            );
          },
          itemCount: transactions.length,
        ));
  }
}
