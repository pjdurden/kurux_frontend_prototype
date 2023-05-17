import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class buySellEquityResponse {
  final bool bought;
  final String boughtR;

  const buySellEquityResponse({
    required this.bought,
    required this.boughtR,
  });

  factory buySellEquityResponse.fromJson(dynamic json) {
    bool boughtStatus = false;
    String boughtResponse;
    if (json.toString() == 'Stock Transfer Done') {
      boughtStatus = true;
      boughtResponse = 'Stock Transfer Done';
    } else {
      boughtResponse = json['error'];
    }
    return buySellEquityResponse(bought: boughtStatus, boughtR: boughtResponse);
  }
}

Future<buySellEquityResponse> tryBuy(String Buyer_Id, String PIN,
    String Ticker_Symbol, String Units, String Price_Per_Unit) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Buy_Equity));

  request.body = json.encode({
    'Buyer_Id': Buyer_Id,
    'PIN': PIN,
    'Ticker_Symbol': Ticker_Symbol,
    'Units': Units,
    'Price_Per_Unit': Price_Per_Unit
  });
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return buySellEquityResponse
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

Future<buySellEquityResponse> trySell(String Buyer_Id, String PIN,
    String Ticker_Symbol, String Units, String Price_Per_Unit) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Sell_Equity));

  request.body = json.encode({
    'Seller_Id': Buyer_Id,
    'PIN': PIN,
    'Ticker_Symbol': Ticker_Symbol,
    'Units': Units,
    'Price_Per_Unit': Price_Per_Unit
  });
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return buySellEquityResponse
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
