import 'package:flutter/material.dart';
import 'package:despesas_app/components/transaction_user.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pessoal Expenses'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: const Card(
              color: Colors.purple,
              elevation: 2,
              child: Text(
                'Graphic',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const TransactionUser(),
        ],
      ),
    );
  }
}
