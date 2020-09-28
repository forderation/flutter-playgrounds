import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  // Use this for force orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
    Transaction(id: 't1', amount: 99.65, date: DateTime.now(), title: 'Shoes'),
    Transaction(id: 't2', amount: 78.99, date: DateTime.now(), title: 'Shirt'),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return userTransaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _setShowChart() {
    setState(() {
      _showChart = !_showChart;
    });
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
        isScrollControlled: true,
        context: ctx,
        builder: (builderContext) {
          return SingleChildScrollView(
              child: NewTransaction(_addUserTransaction));
        });
  }

  void _deleteTransactionFromList(String id) {
    setState(() {
      userTransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(
        'Flutter App',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewTransaction(context)),
        Row(
          children: [
            GestureDetector(
              child: Text(
                'Show chart',
                style: Theme.of(context).textTheme.button,
              ),
              onTap: _setShowChart,
            ),
            // adjust switch button based on OS
            Switch.adaptive(
              value: _showChart,
              onChanged: (bool _) {
                _setShowChart();
              },
            )
          ],
        ),
      ],
    );
    final heightAvailable = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final isPotrait = mediaQuery.orientation == Orientation.portrait;
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _showChart
                  ? Container(
                      height: isPotrait
                          ? heightAvailable * 0.3
                          : heightAvailable * 0.7,
                      child: Chart(_recentTransactions),
                    )
                  : Padding(padding: EdgeInsets.all(5)),
              Container(
                width: mediaQuery.size.width,
                child: TransactionList(
                    userTransaction, _deleteTransactionFromList),
                height: _showChart
                    ? isPotrait ? heightAvailable * 0.7 : heightAvailable * 0.3
                    : heightAvailable * 1,
              )
            ],
          ),
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
