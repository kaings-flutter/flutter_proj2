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
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2)),
                    child: Text(
                      '\$ ${transactions[idx].amount}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactions[idx].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        new DateFormat().format(transactions[idx].date),
                        // new DateFormat('yyyy-mm-dd').format(tx.date),  // you can also do this
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: transactions.length,
        ));
  }
}
