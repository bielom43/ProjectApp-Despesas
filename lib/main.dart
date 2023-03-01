import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:despesas_app/components/chart.dart';
import 'package:despesas_app/components/transactio_form.dart';
import 'package:despesas_app/components/transaction_list.dart';
import '../models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData.light();

    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        brightness: Brightness.light,
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.black,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
  final List<Transaction> _transactions = [];

  bool _showChart = false;

  List<Transaction> get _recenTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransactions(String title, double value, DateTime date) {
    final newTrasaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
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

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final iconList = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.graph_square_fill : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = AppBar(
      title: const Text('Pessoal Expenses'),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: const Icon(
            Icons.add,
          ),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight =
        mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.30),
                child: Chart(_recenTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.70),
                child: TransactionList(transactions: _transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Pessoal Expenses'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : isLandscape
                    ? Container()
                    : FloatingActionButton(
                        onPressed: () => _openTransactionFormModal(context),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
  }
}
