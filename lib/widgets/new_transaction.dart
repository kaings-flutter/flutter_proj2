import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatelessWidget {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  void submittedData() {
    addTransaction(titleInput.text, double.parse(amountInput.text));
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
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountInput,
                keyboardType: TextInputType
                    .number, // limit the input type (floating keyboard) to number only
                onSubmitted: (_) => submittedData,
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
