import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: MyHomePage(),
        theme: ThemeData(
          // primarySwatch -- diversify colors by their shades
          primarySwatch: Colors.purple,
          // some additional color that combines with primarySwatch
          accentColor: Colors.amber,
          // set theme for text
          textTheme: ThemeData.light().textTheme.copyWith(
              // preset button style. Rewrite default button color to white
              button: TextStyle(color: Colors.white)),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> _userTransactions = [
  //   Transaction(
  //       id: 't1',
  //       title: 'Nike Shoes',
  //       amount: 299.9,
  //       date: DateTime.now().subtract(Duration(days: 1))),
  //   Transaction(
  //       id: 't2',
  //       title: 'GSchock Watch',
  //       amount: 599.9,
  //       date: DateTime.now().subtract(Duration(days: 2)))
  // ];

  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'Nike Shoes', amount: 299.9, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'GSchock Watch', amount: 599.9, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      // similar to filter method of Javascript
      return transaction.date
          .isAfter(transaction.date.subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(
      String _title, double _amount, DateTime _transactionDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: _title,
        amount: _amount,
        date: _transactionDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String _id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == _id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (builderCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Theme.of(context)
          .primaryColorDark, // using the shade of one primary Theme color
      title: Text('Flutter App'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(_userTransactions, _deleteTransaction),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // to adjust floatingActionButton alignment/location
    );
  }
}
