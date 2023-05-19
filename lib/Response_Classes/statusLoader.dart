import 'package:http/http.dart' as http;
import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';

Future<String> fetchInitialStatus() async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  final response = await http.get(Uri.parse(Status), headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body.toString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}
