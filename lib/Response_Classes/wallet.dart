import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class balanceResponse {
  final int balance;
  final String BalanceResponse;

  const balanceResponse({
    required this.balance,
    required this.BalanceResponse,
  });

  factory balanceResponse.fromJson(Map<String, dynamic> json) {
    int balanceee = -1;
    String BalanceResponseee = "";
    if (json.containsKey('balance')) {
      balanceee = json['balance'];
      BalanceResponseee = 'balance retrieval successful';
    } else {
      BalanceResponseee = json['error'];
    }
    return balanceResponse(
        balance: balanceee, BalanceResponse: BalanceResponseee);
  }
}

Future<balanceResponse> tryBalCheck(String User_Id, String PIN) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Balance_Check));

  request.body = json.encode({'User_Id': User_Id, 'PIN': PIN});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return balanceResponse
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

class SendAddMoney {
  final bool sent_added;
  final String sent_added_Response;

  const SendAddMoney({
    required this.sent_added_Response,
    required this.sent_added,
  });

  factory SendAddMoney.fromJson(Map<String, dynamic> json) {
    bool sent_added_status = false;
    String sent_added_Response_status = "";
    if (json.containsKey('msg')) {
      sent_added_status = true;
      sent_added_Response_status = 'Transaction done';
    } else {
      sent_added_Response_status = json['error'];
    }
    return SendAddMoney(
        sent_added: sent_added_status,
        sent_added_Response: sent_added_Response_status);
  }
}

Future<SendAddMoney> trySend(String Sender_User_Id, String Reciever_User_Id,
    String PIN, String Amount) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Balance_Send));

  request.body = json.encode({
    'Sender_User_Id': Sender_User_Id,
    'Reciever_User_Id': Reciever_User_Id,
    'PIN': PIN,
    'Amount': Amount
  });
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SendAddMoney.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

Future<SendAddMoney> tryAdd(
    String User_Id, String PIN, String Amount, String Master_Pass) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Balance_Add));

  request.body = json.encode({
    'User_Id': User_Id,
    'PIN': PIN,
    'Amount': Amount,
    'Master_Pass': Master_Pass
  });
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return SendAddMoney.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
