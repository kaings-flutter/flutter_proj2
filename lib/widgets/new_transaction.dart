import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() {
    // TODO: implement createState
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectedDate;

  void _submittedData() {
    final inputTitle = _titleInput.text;
    final inputAmount = double.parse(_amountInput.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
        _titleInput.text, double.parse(_amountInput.text), _selectedDate);

    // close the bottomSheet after add transaction
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    }).catchError((err) {
      print('err..... $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: _titleInput,
                onSubmitted: (_) => _submittedData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: _amountInput,
                keyboardType: TextInputType
                    .number, // limit the input type (floating keyboard) to number only
                onSubmitted: (_) => _submittedData(),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text((_selectedDate == null)
                          ? 'No Date Chosen!'
                          : DateFormat.yMMMMd().format(_selectedDate)),
                    ),
                    FlatButton(
                        onPressed: _showDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submittedData,
                child: Text(
                  'Add Transaction',
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ));
  }
}
