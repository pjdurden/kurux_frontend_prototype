import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Other_Pages/wallet_page.dart';
import 'package:kurux_frontend_prototype/bottomNavigator.dart';
import 'package:kurux_frontend_prototype/login_page.dart';

import 'Other_Pages/company_details.dart';
import 'Portfolio_page.dart';
import 'Response_Classes/get_company_list.dart';
import 'Response_Classes/api_links.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.user_id});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String user_id;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CompanyList> companylist;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    companylist = fetchCompanyList();
  }

  void onTabTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Portfolio_Page(user_id: widget.user_id),
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: bottomBar(),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped,
      ),
      body: FutureBuilder<CompanyList>(
        future: companylist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.companylist.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => company_details_page(
                              company_id: snapshot.data!.companylist
                                  .elementAt(index)
                                  .Ticker_Symbol,
                              user_id: widget.user_id),
                        ),
                      );
                    },
                    leading: Icon(
                      Icons.arrow_forward_outlined,
                    ),
                    subtitle: Text(snapshot.data!.companylist
                        .elementAt(index)
                        .Product_Service_Desc),
                    trailing: Text('IPEO Price: ' +
                        snapshot.data!.companylist.elementAt(index).IPEO_Price),
                    title: Text(
                        '${snapshot.data!.companylist.elementAt(index).Company_Name} (${snapshot.data!.companylist.elementAt(index).Ticker_Symbol})'),
                  );
                });

            // padding: const EdgeInsets.all(8),
            // children: <Widget>[
            //   Container(
            //     height: 50,
            //     color: Color.fromARGB(255, 0, 0, 0),
            //     child: Center(
            //         child: Text('Company - ' +
            //             snapshot.data!.companylist.first.Company_Name)),
            //   ),
            //   Container(
            //     height: 50,
            //     color: Color.fromARGB(255, 65, 63, 63),
            //     child: Center(
            //         child: Text(
            //             'Owner -' + snapshot.data!.companylist.first.Owner)),
            //   ),
            //   Container(
            //     height: 50,
            //     color: Color.fromARGB(255, 0, 0, 0),
            //     child: Center(
            //         child: Text('Ticker_Symbol -' +
            //             snapshot.data!.companylist.first.Ticker_Symbol)),
            //   ),
            //   Container(
            //     height: 50,
            //     color: Color.fromARGB(255, 65, 63, 63),
            //     child: Center(
            //         child: Text('Company Website -' +
            //             snapshot.data!.companylist.first.Company_Website)),
            //   ),
            //   Container(
            //     height: 50,
            //     color: Color.fromARGB(255, 0, 0, 0),
            //     child: Center(
            //         child: Text('Product Service Description -' +
            //             snapshot
            //                 .data!.companylist.first.Product_Service_Desc)),

            // Text(snapshot.data!.companylist.first.Company_Name);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),

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
