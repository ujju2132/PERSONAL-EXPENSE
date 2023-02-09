import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraint) {
            return Column(children: [
              SizedBox(
                height: constraint.maxHeight*0.25,
              ),
              Container(
                height: constraint.maxHeight*0.31,
                width: constraint.maxWidth*0.17,
                child:
                    Image.asset('assets/images/waiting.png', fit: BoxFit.fill),
              ),
              Text(
                'No transaction added yet!!',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]);
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(5),
                elevation: 30,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: FittedBox(
                        child: Text(
                          'Rs.${transactions[index].amount}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width  > 460 ?
                  TextButton.icon(onPressed: () {
                      deleteTx(transactions[index].id);
                    }, 
                    icon: Icon(Icons.delete), 
                    label: Text('Delete'),
                    ) 
                    : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      deleteTx(transactions[index].id);
                    },
                  ),
                ),
              );
            });
  }
}
