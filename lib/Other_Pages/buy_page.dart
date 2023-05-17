import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/buy_equity_post.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../Response_Classes/avgbuysellprice.dart';
import '../Response_Classes/wallet.dart';
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
  final _secondFormKey = GlobalKey<FormState>();
  // late Future<User_Balance> userBalance;
  late Future<AvgBuySellPrc> companyPrice;

  int _selectedIndex = 0;
  TextEditingController pinController = TextEditingController();
  TextEditingController Units = TextEditingController();
  TextEditingController Price_Per_Unit = TextEditingController();
  TextEditingController PIN = TextEditingController();

  int units = 0;
  int price_per_unit = 0;
  int amount = 0;

  void _changesUnits() {
    if (Units.text.isNotEmpty) {
      units = int.parse(Units.text);
    } else
      units = 0;
    setState(() {
      amount = units * price_per_unit;
    });
  }

  void _changesPrice() {
    if (Price_Per_Unit.text.isNotEmpty) {
      price_per_unit = int.parse(Price_Per_Unit.text);
    } else
      price_per_unit = 0;
    setState(() {
      amount = units * price_per_unit;
    });
  }

  @override
  void initState() {
    super.initState();
    Units.addListener(_changesUnits);
    Price_Per_Unit.addListener(_changesPrice);
    companyPrice = tryAvgSellPRC(widget.company_id);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    Units.dispose();
    Price_Per_Unit.dispose();
    pinController.dispose();
    PIN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Buy ' + widget.company_id),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
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
          FutureBuilder<AvgBuySellPrc>(
              future: companyPrice,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      Center(
                          child: new Text('Average Sell Price for ' +
                              widget.company_id +
                              ': ' +
                              snapshot.data!.price.toString()))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(child: const CircularProgressIndicator());
              }),
          Form(
              key: _secondFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: Units,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Units to buy',
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
                      controller: Price_Per_Unit,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Give Buying Price per Unit',
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
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    children: [
                      Center(child: new Text('Amount: ' + (amount).toString()))
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          child: Text('Buy'),
                          onPressed: () {
                            if (_secondFormKey.currentState!.validate()) {
                              // userBalance = fetch_Balance();
                              Future<buySellEquityResponse> buyResponse =
                                  tryBuy(
                                      widget.user_id,
                                      PIN.text,
                                      widget.company_id,
                                      Units.text,
                                      Price_Per_Unit.text);

                              buyResponse.then((data) {
                                if (data.bought) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Stock Transfer Done')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('error: ' + data.boughtR)));
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
