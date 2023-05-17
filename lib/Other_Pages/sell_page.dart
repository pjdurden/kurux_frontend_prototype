import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/buy_equity_post.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_portfolio.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../Response_Classes/avgbuysellprice.dart';
import '../Response_Classes/wallet.dart';
import '../bottomNavigator.dart';

class sell_order_page extends StatefulWidget {
  const sell_order_page(
      {super.key, required this.company_id, required this.user_id});

  final PortfolioDetails company_id;
  final String user_id;

  @override
  State<sell_order_page> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<sell_order_page> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
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

  @override
  void initState() {
    super.initState();
    companyPrice = tryAvgSellPRC(widget.company_id.Ticker_Symbol);
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
          title: Text('Sell ' + widget.company_id.Ticker_Symbol),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          FutureBuilder<AvgBuySellPrc>(
              future: companyPrice,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(
                    leading: Icon(
                      Icons.arrow_forward_outlined,
                    ),
                    subtitle: Text('Units : ' + widget.company_id.Units),
                    trailing: Text('Average Sell Price : ' +
                        snapshot.data!.price.toString()),
                    title: Text(
                        '${widget.company_id.Company_Name} (${widget.company_id.Ticker_Symbol})'),
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
                        labelText: 'Units to Sell',
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
                        labelText: 'Give Selling Price per Unit',
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
                          child:
                              Text('Sell ' + widget.company_id.Ticker_Symbol),
                          onPressed: () {
                            if (_secondFormKey.currentState!.validate()) {
                              // userBalance = fetch_Balance();
                              Future<buySellEquityResponse> sellResponse =
                                  trySell(
                                      widget.user_id,
                                      PIN.text,
                                      widget.company_id.Ticker_Symbol,
                                      Units.text,
                                      Price_Per_Unit.text);

                              sellResponse.then((data) {
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
