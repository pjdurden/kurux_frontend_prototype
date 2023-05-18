// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Other_Pages/cancel_order_page.dart';
import 'package:kurux_frontend_prototype/Other_Pages/wallet_page.dart';
import 'package:kurux_frontend_prototype/Response_Classes/order_history.dart';
import 'package:kurux_frontend_prototype/Response_Classes/orders.dart';

import '../orders_page.dart';

class order_history_page extends StatefulWidget {
  const order_history_page({super.key, required this.user_id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String user_id;

  @override
  State<order_history_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<order_history_page> {
  late Future<OrderHistoryList> order_history;

  @override
  void initState() {
    super.initState();
    order_history = fetch_Order_History(widget.user_id);
  }

  final List<String> order_names = ["Buy", "Sell"];

  // ···

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Portfolio_Page object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('My Order History'),
      ),

      body: FutureBuilder<OrderHistoryList>(
          future: order_history,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!snapshot.data!.list_Empty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.historyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: Text(
                            snapshot.data!.historyList.elementAt(index).Type),
                        subtitle: Text(
                            'Units : ${snapshot.data!.historyList.elementAt(index).Units}'),
                        title: Text(
                            '${snapshot.data!.historyList.elementAt(index).Ticker_Symbol} Price per Unit : (${snapshot.data!.historyList.elementAt(index).Price_Per_Unit.toString()})'),
                      );
                    });
              } else {
                return const ListTile(
                  leading: CircleAvatar(
                    child: Text('NULL'),
                  ),
                  title: Text("No Orders Executed Till Now"),
                );
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          }),

      //Sell Orders

      // itemCount > 0
      //     ? ListView.builder(
      //         itemCount: itemCount,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             title: Text('Item ${index + 1}'),
      //           );
      //         },
      //       )
      //     : const Center(child: Text('No items')),

      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      // child: Column(
      //   // Column is also a layout widget. It takes a list of children and
      //   // arranges them vertically. By default, it sizes itself to fit its
      //   // children horizontally, and tries to be as tall as its parent.
      //   //
      //   // Invoke "debug painting" (press "p" in the console, choose the
      //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //   // to see the wireframe for each widget.
      //   //
      //   // Column has various properties to control how it sizes itself and
      //   // how it positions its children. Here we use mainAxisAlignment to
      //   // center the children vertically; the main axis here is the vertical
      //   // axis because Columns are vertical (the cross axis would be
      //   // horizontal).
      //   mainAxisAlignment: MainAxisAlignment.left,
      //   children: <Widget>[
      //     const Text(
      //       'You have pushed the button this many times:',
      //     ),
      //     Text(
      //       '$_counter',
      //       style: Theme.of(context).textTheme.headlineMedium,
      //     ),
      // ],
    );
  }
}
