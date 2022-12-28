import 'package:despesas_app/components/chart.dart';
import 'package:despesas_app/components/transactio_form.dart';
import 'package:flutter/material.dart';
import 'package:despesas_app/components/transaction_list.dart';
import '../models/transaction.dart';
import 'dart:math';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        brightness: Brightness.light,
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.black,
        ),
        textTheme: theme.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 'tran5',
      title: 'Conta de Janeiro',
      value: 150,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 'tran1',
      title: 'Futebol Ball',
      value: 80.2,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 'tran2',
      title: 'PS5',
      value: 300,
      date: DateTime.now().subtract(const Duration(days: 3)),
    )
  ];

  List<Transaction> get _recenTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

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

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransactions);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recenTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
