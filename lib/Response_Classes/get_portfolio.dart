import 'dart:convert';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class PortfolioList {
  final bool portfolio_recieved;
  final List<PortfolioDetails> companylist;

  const PortfolioList(
      {required this.companylist, required this.portfolio_recieved});

  factory PortfolioList.fromJson(dynamic json) {
    bool got_portfolio = false;
    List<PortfolioDetails> temp_list = <PortfolioDetails>[];

    if (json is List) {
      got_portfolio = true;
      if (json.length > 0) {
        for (int i = 0; i < json.length; i++) {
          PortfolioDetails current = PortfolioDetails.fromJson(json[i]);
          temp_list.add(current);
        }
      }
    }

    return PortfolioList(
        portfolio_recieved: got_portfolio, companylist: temp_list);
  }
}

Future<PortfolioList> fetchPortfolioList(String User_Id) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(User_Portfolio));

  request.body = json.encode({'User_Id': User_Id});

  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PortfolioList.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}

class PortfolioDetails {
  final String Company_Name;
  final String Ticker_Symbol;
  final String Total_Spent;
  final String Units;

  const PortfolioDetails({
    required this.Company_Name,
    required this.Units,
    required this.Total_Spent,
    required this.Ticker_Symbol,
  });

  factory PortfolioDetails.fromJson(Map<String, dynamic> json) {
    return PortfolioDetails(
      Company_Name: json['Company_Name'],
      Units: json['Units'],
      Total_Spent: json['Total_Spent'],
      Ticker_Symbol: json['Ticker_Symbol'],
    );
  }
}
