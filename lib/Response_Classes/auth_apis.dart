import 'dart:convert';
import 'dart:math';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class loginResponse {
  final bool Auth;
  final String AuthResponse;

  const loginResponse({
    required this.Auth,
    required this.AuthResponse,
  });

  factory loginResponse.fromJson(Map<String, dynamic> json) {
    bool authStatus = false;
    String authResponse;
    if (json.containsKey('auth')) {
      authStatus = true;
      authResponse = json['auth'];
    } else {
      authResponse = json['error'];
    }
    return loginResponse(Auth: authStatus, AuthResponse: authResponse);
  }
}

Future<loginResponse> tryAuth(String User_Id, String User_Pass) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Auth_Link));

  request.body = json.encode({
    'User_Id': User_Id,
    'User_Pass': User_Pass,
  });
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return loginResponse
        .fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Server Error');
  }
}

// bool authExec(String User_Id, String User_Pass) {
//   bool authFlag = false;
//    tryAuth(User_Id, User_Pass).then((data) {
//     if (data.Auth) {
//       authFlag = true;
//     }
//   }, onError: (e) {
//     print(e);
//   });
//   return authFlag;
// }
