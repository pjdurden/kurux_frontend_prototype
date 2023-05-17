import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> post_api_call( String api_link ,Map<String,String> request_body  ) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(api_link));

  request.body = json.encode(request_body);
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return await response.stream.bytesToString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}