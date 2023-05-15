import 'dart:convert';

import 'package:kurux_frontend_prototype/Response_Classes/api_links.dart';
import 'package:http/http.dart' as http;

class CompanyList {
  final List<CompanyDetails> companylist;

  const CompanyList({required this.companylist});

  factory CompanyList.fromJson(List<dynamic> json) {
    int length_json = json.length;
    List<CompanyDetails> temp_list = <CompanyDetails>[];
    for (int i = 0; i < length_json; i++) {
      CompanyDetails current = CompanyDetails.fromJson(json[i]);
      temp_list.add(current);
    }
    return CompanyList(companylist: temp_list);
  }
}

class CompanyDetails {
  final String Company_Name;
  final String Owner;
  final String Ticker_Symbol;
  final String IPEO_Price;
  final String Company_Website;
  final String Company_Linkedin;
  final String Product_Service_Desc;
  final String Earlier_Fund_Raised;
  final String Revenue;
  final String Is_Profitable;
  final String Company_Size;
  final String Existing_Liabilities;
  final String Pitch_Link;

  const CompanyDetails({
    required this.Company_Name,
    required this.Company_Linkedin,
    required this.Company_Size,
    required this.Company_Website,
    required this.Earlier_Fund_Raised,
    required this.Existing_Liabilities,
    required this.IPEO_Price,
    required this.Is_Profitable,
    required this.Owner,
    required this.Pitch_Link,
    required this.Product_Service_Desc,
    required this.Revenue,
    required this.Ticker_Symbol,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      Company_Linkedin: json['Company_Linkedin'],
      Company_Name: json['Company_Name'],
      Company_Size: json['Company_Size'],
      Company_Website: json['Company_Website'],
      Earlier_Fund_Raised: json['Earlier_Fund_Raised'],
      Existing_Liabilities: json['Existing_Liabilities'],
      IPEO_Price: json['IPEO_Price'],
      Is_Profitable: json['Is_Profitable'],
      Owner: json['Owner'],
      Pitch_Link: json['Pitch_Link'],
      Product_Service_Desc: json['Product_Service_Desc'],
      Revenue: json['Revenue'],
      Ticker_Symbol: json['Ticker_Symbol'],
    );
  }
}

Future<CompanyList> fetchCompanyList() async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };
  final response =
      await http.get(Uri.parse(GET_COMPANY_LIST), headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CompanyList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}

Future<CompanyDetails> fetchCompanyDetails(String ticker_symbol) async {
  var headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  var request = http.Request('POST', Uri.parse(Single_Company_Details));

  request.body = json.encode({'Ticker_Symbol': ticker_symbol});
  request.headers.addAll(headers);

  final response = await request.send();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(response.body);
    return CompanyDetails.fromJson(
        jsonDecode(await response.stream.bytesToString()));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load company list');
  }
}
