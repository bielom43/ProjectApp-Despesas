import 'dart:math';
import 'package:despesas_app/components/transactio_form.dart';
import 'package:despesas_app/components/transaction_list.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 'tran1',
      title: 'Futebol Ball',
      value: 80.2,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tran2',
      title: 'PS5',
      value: 4.909,
      date: DateTime.now(),
    )
  ];

  _addTransactions(String title, double value) {
    final newTrasaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTrasaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(transactions: _transactions),
        TransactionForm(_addTransactions),
      ],
    );
  }
}
