import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class cancelOrder {
  final bool orderCancelled;
  final String error_Response;

  const cancelOrder({
    required this.orderCancelled,
    required this.error_Response,
  });

  factory cancelOrder.fromJson(dynamic json) {
    bool order_cancel = false;
    String error_response = "";

    if (json is String &&
        (json.toString() == 'Order Cancelled' ||
            json.toString() == 'Order cancelled')) {
      order_cancel = true;
      error_response = 'Order Cancelled';
    } else {
      error_response = json['error'];
    }

    return cancelOrder(
        orderCancelled: order_cancel, error_Response: error_response);
  }
}

Future<cancelOrder> tryBuyOrderCancel(
    String user_id, String user_pin, int order_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Cancel_Buy_Order));

  request.body =
      json.encode({'User_Id': user_id, 'PIN': user_pin, 'Order_Id': order_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return cancelOrder
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

Future<cancelOrder> trySellOrderCancel(
    String user_id, String user_pin, int order_id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Cancel_Sell_Order));

  request.body =
      json.encode({'User_Id': user_id, 'PIN': user_pin, 'Order_Id': order_id});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return cancelOrder
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
