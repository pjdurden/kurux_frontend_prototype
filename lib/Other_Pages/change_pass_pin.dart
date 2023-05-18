import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/buy_equity_post.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../Response_Classes/avgbuysellprice.dart';
import '../Response_Classes/tran_history.dart';
import '../Response_Classes/wallet.dart';
import '../bottomNavigator.dart';

class change_pass_pin extends StatefulWidget {
  const change_pass_pin({super.key, required this.Type});

  final String Type;

  @override
  State<change_pass_pin> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<change_pass_pin> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  // late Future<User_Balance> userBalance;

  int _selectedIndex = 0;
  TextEditingController oldPassController = TextEditingController();
  TextEditingController user_id = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  int units = 0;
  int price_per_unit = 0;
  int amount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    oldPassController.dispose();
    user_id.dispose();
    newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'KuruX Funding Portal',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 30),
          )),
      ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          Center(
              child: new Text(
            'Update ' + widget.Type,
            textScaleFactor: 2,
          )),
        ],
      ),
      Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: user_id,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Id',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: oldPassController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type Old Credentials',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: newPassController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type New Credentials',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter value';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      child: Text('Update ' + widget.Type),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // userBalance = fetch_Balance();
                        }
                      })),
            ],
          )),
    ]));
  }
}
