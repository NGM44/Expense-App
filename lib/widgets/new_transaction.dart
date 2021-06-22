import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleName = TextEditingController();

  final amountName = TextEditingController();
  DateTime _selectedDate;
  void submitData() {
    final enteredTitle = titleName.text;
    final enteredAmount = double.parse(amountName.text);
    final enteredDate = _selectedDate;

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    } else {
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleName,
                keyboardType: TextInputType.text,
                //  onSubmitted: (_)=>submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountName,
                keyboardType: TextInputType.number,
                //  onSubmitted: (_)=>submitData,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  textStyle: TextStyle(color: Colors.black, fontSize: 15, fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
