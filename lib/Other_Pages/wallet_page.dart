import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/buy_equity_post.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../Response_Classes/avgbuysellprice.dart';
import '../Response_Classes/wallet.dart';
import '../bottomNavigator.dart';

class wallet_page extends StatefulWidget {
  const wallet_page({super.key, required this.user_id});

  final String user_id;

  @override
  State<wallet_page> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<wallet_page> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _thirdFormKey = GlobalKey<FormState>();
  // late Future<User_Balance> userBalance;

  int _selectedIndex = 0;
  TextEditingController pinController = TextEditingController();
  TextEditingController Reciever_user_id = TextEditingController();
  TextEditingController Amount = TextEditingController();
  TextEditingController PIN = TextEditingController();

  TextEditingController Amount2 = TextEditingController();
  TextEditingController PIN2 = TextEditingController();
  TextEditingController Master_Pass = TextEditingController();

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
    Reciever_user_id.dispose();
    Amount.dispose();
    pinController.dispose();
    PIN.dispose();
    Amount2.dispose();
    PIN2.dispose();
    Master_Pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Wallet'),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              Center(child: new Text('Check Balance', textScaleFactor: 2))
            ],
          ),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PIN',
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
                          child: Text('Fetch Balance'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Future<balanceResponse> user_balance =
                                  tryBalCheck(
                                      widget.user_id, pinController.text);

                              user_balance.then((data) {
                                if (data.balance != -1) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(content: Text('Auth Success')),
                                  // );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Balance: ' +
                                              data.balance.toString())));

                                  // Navigator.pushNamed(
                                  //   context, '/home',
                                  //   arguments: String( nameController.text )
                                  // );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'error: ' + data.BalanceResponse)),
                                  );
                                }
                              }, onError: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Server Error')),
                                );
                              });
                            }
                          })),
                ],
              )),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              Center(child: new Text('Send Money', textScaleFactor: 2))
            ],
          ),
          Form(
              key: _secondFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: Reciever_user_id,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reciever User Id',
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
                      controller: Amount,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
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
                      controller: PIN,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PIN',
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
                          child: Text('Send Money'),
                          onPressed: () {
                            if (_secondFormKey.currentState!.validate()) {
                              // userBalance = fetch_Balance();
                              Future<SendAddMoney> buyResponse = trySend(
                                widget.user_id,
                                Reciever_user_id.text,
                                PIN.text,
                                Amount.text,
                              );

                              buyResponse.then((data) {
                                if (data.sent_added) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Transaction Success')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('error: ' +
                                              data.sent_added_Response)));
                                }
                              }, onError: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Server Error')),
                                );
                              });
                            }
                          })),
                ],
              )),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: [
              Center(child: new Text('Add Money', textScaleFactor: 2))
            ],
          ),
          Form(
              key: _thirdFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: Amount2,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
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
                      controller: PIN2,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PIN',
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
                      controller: Master_Pass,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Master Pass',
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
                          child: Text('Add Money'),
                          onPressed: () {
                            if (_thirdFormKey.currentState!.validate()) {
                              // userBalance = fetch_Balance();
                              Future<SendAddMoney> buyResponse = tryAdd(
                                  widget.user_id,
                                  PIN2.text,
                                  Amount2.text,
                                  Master_Pass.text);

                              buyResponse.then((data) {
                                if (data.sent_added) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Transaction Success')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('error: ' +
                                              data.sent_added_Response)));
                                }
                              }, onError: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Server Error')),
                                );
                              });
                            }
                          })),
                ],
              ))
        ])));
  }
}
