import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate = DateTime.now() ;

  void _submitdata() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {selectedDate = value;});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            right: 10,
            left: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                controller: titleController,
                onSubmitted: (_) => _submitdata(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No Date Choesn!'
                          : 'Picked Date:  ${DateFormat.yMd().format(selectedDate)}'),
                    ),
                    TextButton(
                        onPressed: presentDatePicker,
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.purple)),
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.purple)),
                  onPressed: _submitdata,
                  child: Text('Add Transaction')),
            ],
          ),
        ),
      ),
    );
  }
}
