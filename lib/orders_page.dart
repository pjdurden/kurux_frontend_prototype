// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Other_Pages/cancel_order_page.dart';
import 'package:kurux_frontend_prototype/Other_Pages/wallet_page.dart';
import 'package:kurux_frontend_prototype/Response_Classes/orders.dart';

import 'Other_Pages/order_history_page.dart';

class Orders_Page extends StatefulWidget {
  const Orders_Page({super.key, required this.user_id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String user_id;

  @override
  State<Orders_Page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Orders_Page> {
  late Future<OrderList> orderList;

  int _selectedIndex = 0;

  void refreshBuy() {
    // reload
    setState(() {
      orderList = tryBuyOrderList(widget.user_id);
    });
  }

  void refreshSell() {
    // reload
    setState(() {
      orderList = trySellOrderList(widget.user_id);
    });
  }

  @override
  void initState() {
    super.initState();
    orderList = tryBuyOrderList(widget.user_id);
  }

  final List<String> order_names = ["Buy", "Sell"];

  void onTabTapped(int index) {
    if (index == 0) {
      _selectedIndex = 0;
      refreshBuy();
    } else if (index == 1) {
      _selectedIndex = 1;
      refreshSell();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => order_history_page(
            user_id: widget.user_id,
          ),
        ),
      );
    }
  }

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
        title: Text(order_names[_selectedIndex] + ' Orders'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'Buy Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell_rounded),
            label: 'Sell Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: 'Order History',
          )
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped,
      ),

      body: FutureBuilder<OrderList>(
        future: orderList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.list_recieved) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.orders_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        //go to cancel buy order or sell order
                        String order_Type = 'Buy';
                        if (_selectedIndex == 1) {
                          order_Type = 'Sell';
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => cancel_order_page(
                              order_details:
                                  snapshot.data!.orders_list.elementAt(index),
                              order_type: order_Type,
                              user_id: widget.user_id,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        child: Text(snapshot.data!.orders_list
                            .elementAt(index)
                            .ticker_symbol),
                      ),
                      subtitle: Text(
                          'Units : ${snapshot.data!.orders_list.elementAt(index).Units}'),
                      trailing: const Text('Click here to Cancel Order'),
                      title: Text(
                          '${snapshot.data!.orders_list.elementAt(index).ticker_symbol} Price per Unit : (${snapshot.data!.orders_list.elementAt(index).price_per_unit.toString()})'),
                    );
                  });
            }
            return const ListTile(
              leading: CircleAvatar(
                child: Text('NULL'),
              ),
              title: Text("No Orders Present Currently"),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),

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

      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(widget.user_id),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => wallet_page(
                      user_id: widget.user_id,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
