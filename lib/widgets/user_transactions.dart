import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserTransactionsState();
  }
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'Nike Shoes', amount: 299.9, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'GSchock Watch', amount: 599.9, date: DateTime.now())
  ];

  void _addTransaction(String _title, double _amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: _title,
        amount: _amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(_userTransactions)
      ],
    );
  }
}
