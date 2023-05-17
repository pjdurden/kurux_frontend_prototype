import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/get_company_list.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

import '../bottomNavigator.dart';
import 'buy_page.dart';

class company_details_page extends StatefulWidget {
  const company_details_page(
      {super.key, required this.company_id, required this.user_id});

  final String company_id;
  final String user_id;

  @override
  State<company_details_page> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<company_details_page> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late Future<CompanyDetails> companyDetails;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    companyDetails = fetchCompanyDetails(widget.company_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.company_id),
      ),
      body: FutureBuilder<CompanyDetails>(
        future: companyDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              // padding: const EdgeInsets.all(8),
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            snapshot.data!.Company_Name +
                                ' (' +
                                snapshot.data!.Ticker_Symbol +
                                ')',
                            textScaleFactor: 3))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(child: new Text(snapshot.data!.Product_Service_Desc))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text('Company Website - ' +
                            snapshot.data!.Company_Website))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'IPEO Price - ' + snapshot.data!.IPEO_Price))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'Company Size - ' + snapshot.data!.Company_Size))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text('Revenue - ' + snapshot.data!.Revenue))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'Is_Profitable - ' + snapshot.data!.Is_Profitable))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text('Funds Raised Till Now - ' +
                            snapshot.data!.Earlier_Fund_Raised))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text('Existing Liabilities - ' +
                            snapshot.data!.Existing_Liabilities))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'Parent Company/Owner - ' + snapshot.data!.Owner))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'Linkedin - ' + snapshot.data!.Company_Linkedin))
                  ],
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                        child: new Text(
                            'Pitch Link - ' + snapshot.data!.Pitch_Link))
                  ],
                ),

                //adding button

                Container(
                    height: 80,
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        child: Text('Buy ' + snapshot.data!.Ticker_Symbol,
                            textScaleFactor: 2),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => buy_order_page(
                                company_id: widget.company_id,
                                user_id: widget.user_id,
                              ),
                            ),
                          );
                        })),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(widget.user_id),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
