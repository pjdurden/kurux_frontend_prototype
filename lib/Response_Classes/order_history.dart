import 'dart:convert';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class OrderHistoryList {
  final bool list_Recieved;
  final bool list_Empty;
  final List<OrderHistory> historyList;

  const OrderHistoryList(
      {required this.historyList,
      required this.list_Recieved,
      required this.list_Empty});

  factory OrderHistoryList.fromJson(dynamic json) {
    bool list_there = false;
    bool list_empty = false;
    List<OrderHistory> temp_history = <OrderHistory>[];

    if (json is List) {
      list_there = true;
      list_empty = false;
      for (int i = 0; i < json.length; i++) {
        temp_history.add(OrderHistory.fromJson(json[i]));
      }
    } else if (json is Map && json.containsKey('status')) {
      list_there = true;
      list_empty = true;
    }
    return OrderHistoryList(
        historyList: temp_history,
        list_Recieved: list_there,
        list_Empty: list_empty);
  }
}

class OrderHistory {
  final String Ticker_Symbol;
  final String Type;
  final int Units;
  final int Price_Per_Unit;

  const OrderHistory(
      {required this.Price_Per_Unit,
      required this.Ticker_Symbol,
      required this.Type,
      required this.Units});

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
        Type: json['Type'],
        Price_Per_Unit: json['Price_Per_Unit'],
        Units: json['Units'],
        Ticker_Symbol: json['Ticker_Symbol']);
  }
}

Future<OrderHistoryList> fetch_Order_History(String user_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Order_History_List));

  request.body = json.encode({'User_Id': user_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return OrderHistoryList.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}
