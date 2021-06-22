import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  TransactionList(this.transaction, this.deleteTx, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Text(
            'No Payments Yet',
            style: TextStyle(fontSize: 30, color: Colors.grey[700]),
          )
        : Container(
            height: 550,
            child: ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    child: Card(
                      elevation: 6,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('\₹${transaction[index].amount.toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transaction[index].id),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(transaction[index].date),
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              DateFormat.jm().format(transaction[index].date),
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        title: Text('${transaction[index].title} ', style: TextStyle(height: 2, fontSize: 20)),
                      ),
                    ),
                  );
                }),
          );
  }
}
