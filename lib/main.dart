import 'package:flutter/material.dart';
import 'package:money/models/transaction.dart';
import 'package:money/widgets/chart.dart';
import 'package:money/widgets/new_transaction.dart';
import 'package:money/widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.amber,
          backgroundColor: Colors.blueGrey[100],
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(color: Colors.white),
              ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  void _addTransaction(String txtitle, double txamount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().minute.toString(),
      title: txtitle,
      amount: txamount,
      date: selectedDate,
    );
    setState(() {
      _transaction.add(newTx);
    });
  }

  List<Transaction> get _recentTransaction {
    return _transaction.where(
      (element) {
        return element.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Center(child: Text('Personel Expense')),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChartView(recentTransactions: _recentTransaction),

          // UserTransaction(),
          TransactionList(_transaction, _deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
