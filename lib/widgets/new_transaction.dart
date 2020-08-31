import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();

  void submittedData() {
    final inputTitle = titleInput.text;
    final inputAmount = double.parse(amountInput.text);

    if (inputTitle.isEmpty || inputAmount <= 0) {
      return;
    }

    widget.addTransaction(titleInput.text, double.parse(amountInput.text));
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
                controller: titleInput,
                onSubmitted: (_) => submittedData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountInput,
                keyboardType: TextInputType
                    .number, // limit the input type (floating keyboard) to number only
                onSubmitted: (_) => submittedData(),
              ),
              FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  onPressed: submittedData,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ));
  }
}
