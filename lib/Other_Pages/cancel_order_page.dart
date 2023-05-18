import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/cancelorders.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../Response_Classes/orders.dart';
import '../bottomNavigator.dart';
import '../orders_page.dart';
import 'buy_page.dart';

class cancel_order_page extends StatefulWidget {
  const cancel_order_page(
      {super.key,
      required this.order_details,
      required this.user_id,
      required this.order_type});

  final Orders order_details;
  final String order_type;
  final String user_id;

  @override
  State<cancel_order_page> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<cancel_order_page> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController pinController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Cancel ' +
            widget.order_type +
            ' Order for ' +
            widget.order_details.ticker_symbol),
      ),
      body: Column(children: [
        ListTile(
          leading: CircleAvatar(
            child: Text(widget.order_details.ticker_symbol),
          ),
          subtitle: Text('Order Id : ' + widget.order_details.id.toString()),
          trailing: Text('Price Per Unit : ' +
              widget.order_details.price_per_unit.toString()),
          title: Text(widget.order_details.ticker_symbol +
              ' Units : ' +
              widget.order_details.Units.toString()),
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
                        child: Text('Cancel Order'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Future<cancelOrder> order_response;

                            if (widget.order_type == 'Buy') {
                              order_response = tryBuyOrderCancel(widget.user_id,
                                  pinController.text, widget.order_details.id);
                            } else {
                              order_response = trySellOrderCancel(
                                  widget.user_id,
                                  pinController.text,
                                  widget.order_details.id);
                            }

                            order_response.then((data) {
                              if (data.orderCancelled) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Auth Success')),
                                // );

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Order Cancelled Successfully')));

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Orders_Page(user_id: widget.user_id),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'error: ' + data.error_Response)),
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
      ]),
    );
  }
}
