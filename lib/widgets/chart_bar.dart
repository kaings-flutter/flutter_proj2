import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalShare;

  ChartBar(
      {@required this.label, @required this.amount, @required this.totalShare});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          // if the content of the text grows, it will not wrap, it will shrink its content instead
          child: Text('\$${amount.toStringAsFixed(2)}'),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          // Stack widget allows to stack elements on top of each other (in 3D way)
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: totalShare,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
