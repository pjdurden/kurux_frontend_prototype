import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Response_Classes/get_company_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KuruX',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'KuruX Funding Portal'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<CompanyList> fetchCompanyList() async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  final response = await http.get(
      Uri.parse('https://kuruxtest.onrender.com/crud/get_company_list'),
      headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CompanyList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<CompanyList> companylist;
  @override
  void initState() {
    super.initState();
    companylist = fetchCompanyList();
  }
  // ···

  int itemCount = 30;

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
      body: FutureBuilder<CompanyList>(
        future: companylist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: Center(
                      child: Text('Company - ' +
                          snapshot.data!.companylist.first.Company_Name)),
                ),
                Container(
                  height: 50,
                  color: Color.fromARGB(255, 65, 63, 63),
                  child: Center(
                      child: Text(
                          'Owner -' + snapshot.data!.companylist.first.Owner)),
                ),
                Container(
                  height: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: Center(
                      child: Text('Ticker_Symbol -' +
                          snapshot.data!.companylist.first.Ticker_Symbol)),
                ),
                Container(
                  height: 50,
                  color: Color.fromARGB(255, 65, 63, 63),
                  child: Center(
                      child: Text('Company Website -' +
                          snapshot.data!.companylist.first.Company_Website)),
                ),
                Container(
                  height: 50,
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: Center(
                      child: Text('Product Service Description -' +
                          snapshot
                              .data!.companylist.first.Product_Service_Desc)),
                ),
              ],
            );
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

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('KuruX'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
