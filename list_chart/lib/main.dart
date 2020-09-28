import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(fontFamily: 'OpenSans', color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  final List<Transaction> userTransaction = [
    // Transaction(id: 't1', amount: 99.65, date: DateTime.now(), title: 'Shoes'),
    // Transaction(id: 't2', amount: 78.99, date: DateTime.now(), title: 'Shirt'),
  ];

  List<Transaction> get _recentTransactions {
    return userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addUserTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final txUser = new Transaction(
        amount: txAmount,
        title: txTitle,
        date: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      userTransaction.add(txUser);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addUserTransaction);
        });
  }

  void _deleteTransactionFromList(String id) {
    setState(() {
      userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Flutter App',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context))
      ],
    );
    final heightAvailable = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: heightAvailable * 0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              child:
                  TransactionList(userTransaction, _deleteTransactionFromList),
              height: heightAvailable * 0.6,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
