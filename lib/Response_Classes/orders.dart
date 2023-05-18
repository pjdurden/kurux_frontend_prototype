import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class OrderList {
  final bool list_recieved;
  final List<Orders> orders_list;

  const OrderList({
    required this.orders_list,
    required this.list_recieved,
  });

  factory OrderList.fromJson(dynamic json) {
    bool list_recieved = false;

    List<Orders> temp_list = <Orders>[];
    if (json is List && json.length > 0) {
      list_recieved = true;

      for (int i = 0; i < json.length; i++) {
        temp_list.add(Orders.fromJson(json[i]));
      }
    }

    return OrderList(list_recieved: list_recieved, orders_list: temp_list);
  }
}

class Orders {
  final int Units;
  final int price_per_unit;
  final String ticker_symbol;
  final int id;

  const Orders(
      {required this.Units,
      required this.id,
      required this.price_per_unit,
      required this.ticker_symbol});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
        Units: json['Units'],
        id: json['_id'],
        price_per_unit: json['Price_Per_Unit'],
        ticker_symbol: json['Ticker_Symbol']);
  }
}

Future<OrderList> tryBuyOrderList(String user_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Buy_Order_List));

  request.body = json.encode({'User_Id': user_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return OrderList.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

Future<OrderList> trySellOrderList(String user_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Sell_Order_List));

  request.body = json.encode({'User_Id': user_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return OrderList.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
