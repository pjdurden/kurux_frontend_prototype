import 'dart:convert';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class TranHistoryList {
  final bool list_Recieved;
  final bool list_Empty;
  final List<TranHistory> historyList;

  const TranHistoryList(
      {required this.historyList,
      required this.list_Recieved,
      required this.list_Empty});

  factory TranHistoryList.fromJson(dynamic json) {
    bool list_there = false;
    bool list_empty = false;
    List<TranHistory> temp_history = <TranHistory>[];

    if (json is List) {
      list_there = true;
      list_empty = false;
      for (int i = 0; i < json.length; i++) {
        temp_history.add(TranHistory.fromJson(json[i]));
      }
    } else if (json is Map && json.containsKey('status')) {
      list_there = true;
      list_empty = true;
    }
    return TranHistoryList(
        historyList: temp_history,
        list_Recieved: list_there,
        list_Empty: list_empty);
  }
}

class TranHistory {
  final int Amount;
  final String Type;
  final String Message;

  const TranHistory(
      {required this.Message, required this.Type, required this.Amount});

  factory TranHistory.fromJson(Map<String, dynamic> json) {
    return TranHistory(
      Type: json['Type'],
      Amount: json['Amount'],
      Message: json['Message'],
    );
  }
}

Future<TranHistoryList> fetch_Order_History(String user_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Tran_History_List));

  request.body = json.encode({'User_Id': user_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return TranHistoryList.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}
