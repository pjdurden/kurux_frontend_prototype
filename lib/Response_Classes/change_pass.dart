import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class ChangePass {
  final bool Pass;
  final String PassResponse;

  const ChangePass({
    required this.Pass,
    required this.PassResponse,
  });

  factory ChangePass.fromJson(Map<String, dynamic> json) {
    bool PassStatus = false;
    String PASSResponse;
    if (json.containsKey('Success')) {
      PassStatus = true;
      PASSResponse = json['Success'];
    } else {
      PASSResponse = json['error'];
    }
    return ChangePass(Pass: PassStatus, PassResponse: PASSResponse);
  }
}

Future<ChangePass> tryChangePass(
    String User_Id, String Old_Pass, String New_Pass) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(PassChange_Link));

  request.body = json
      .encode({'User_Id': User_Id, 'Old_Pass': Old_Pass, 'New_Pass': New_Pass});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ChangePass.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}
