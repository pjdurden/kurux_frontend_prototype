import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class buyEquityResponse {
  final bool bought;
  final String boughtR;

  const buyEquityResponse({
    required this.bought,
    required this.boughtR,
  });

  factory buyEquityResponse.fromJson(dynamic json) {
    bool boughtStatus = false;
    String boughtResponse;
    if (json.toString() == 'Stock Transfer Done') {
      boughtStatus = true;
      boughtResponse = 'Stock Transfer Done';
    } else {
      boughtResponse = json['error'];
    }
    return buyEquityResponse(bought: boughtStatus, boughtR: boughtResponse);
  }
}

Future<buyEquityResponse> tryBuyEquity(String Buyer_Id, String PIN,
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
    return buyEquityResponse
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
