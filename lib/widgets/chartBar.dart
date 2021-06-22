import 'package:flutter/material.dart';

class chartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingpercent;
  const chartBar(this.label, this.spendingAmount, this.spendingpercent);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\₹ ${spendingAmount.toStringAsFixed(0)}'),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 1.0),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingpercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.amber, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Text(label),
      ],
    );
  }
}
