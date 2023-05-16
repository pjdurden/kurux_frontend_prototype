import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../bottomNavigator.dart';

class buy_order_page extends StatefulWidget {
  const buy_order_page(
      {super.key, required this.company_id, required this.user_id});

  final String company_id;
  final String user_id;

  @override
  State<buy_order_page> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<buy_order_page> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late Future<User_Balance> userBalance;
  late Future<Company_Price> companyPrice;

  int _selectedIndex = 0;
  TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    companyPrice = current_company_sell_price(widget.company_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Buy ' + widget.company_id),
        ),
        body: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: pinController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User PIN',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pin';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      child: Text('Fetch Balance'),
                      onPressed: () {
                        userBalance = fetch_Balance();
                      }))
            ]),
            FutureBuilder<User_Balance>(
                future: User_Balance,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: [
                        Center(child: new Text(snapshot.data!.balance))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }),
            FutureBuilder<Company_Price>(
                future: companyDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: [
                        Center(child: new Text(snapshot.data!.balance))
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }),
          ],
        ));
  }
}
