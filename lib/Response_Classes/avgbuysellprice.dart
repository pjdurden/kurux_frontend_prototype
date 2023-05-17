import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class AvgBuySellPrc {
  final int price;
  final String priceResponse;

  const AvgBuySellPrc({
    required this.price,
    required this.priceResponse,
  });

  factory AvgBuySellPrc.fromJson(dynamic json) {
    int priceStatus = -1;
    String priceResponseStatus = "";
    if (json is int || json is double) {
      priceStatus = json.ceil();
      priceResponseStatus = 'balance retrieval successful';
    } else {
      priceResponseStatus = json['error'];
    }
    return AvgBuySellPrc(
        price: priceStatus, priceResponse: priceResponseStatus);
  }
}

Future<AvgBuySellPrc> tryAvgBuyPRC(String Ticker_Symbol) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Avg_Buy_Price));

  request.body = json.encode({'Ticker_Symbol': Ticker_Symbol});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AvgBuySellPrc.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

Future<AvgBuySellPrc> tryAvgSellPRC(String Ticker_Symbol) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Avg_Sell_Price));

  request.body = json.encode({'Ticker_Symbol': Ticker_Symbol});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AvgBuySellPrc.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
