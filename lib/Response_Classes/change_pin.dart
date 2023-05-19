import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class ChangePin {
  final bool Pin;
  final String PinResponse;

  const ChangePin({
    required this.Pin,
    required this.PinResponse,
  });

  factory ChangePin.fromJson(Map<String, dynamic> json) {
    bool PinStatus = false;
    String PINResponse;
    if (json.containsKey('Success')) {
      PinStatus = true;
      PINResponse = json['Success'];
    } else {
      PINResponse = json['error'];
    }
    return ChangePin(Pin: PinStatus, PinResponse: PINResponse);
  }
}

Future<ChangePin> tryChangePin(
    String User_Id, String Old_PIN, String New_PIN) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(PinChange_Link));

  request.body =
      json.encode({'User_Id': User_Id, 'Old_PIN': Old_PIN, 'New_PIN': New_PIN});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ChangePin.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
