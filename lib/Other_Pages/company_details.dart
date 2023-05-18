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
            return SingleChildScrollView(
                child: Column(
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
                            textScaleFactor: 2))
                  ],
                ),

                ListTile(
                  leading: Icon(
                    Icons.details_outlined,
                  ),
                  trailing: Text('Product And Service Description'),
                  subtitle: Text('As per company details'),
                  title: Text(snapshot.data!.Product_Service_Desc),
                ),

                ListTile(
                  leading: Icon(
                    Icons.web,
                  ),
                  trailing: Text('Company Website'),
                  subtitle: Text('Online Presence'),
                  title: Text(snapshot.data!.Company_Website),
                ),

                ListTile(
                  leading: Icon(
                    Icons.monetization_on_outlined,
                  ),
                  trailing: Text('IPEO Price'),
                  subtitle:
                      Text('Initial Private Equity Offering price on KuruX'),
                  title: Text(snapshot.data!.IPEO_Price),
                ),

                ListTile(
                  leading: Icon(
                    Icons.people_alt_outlined,
                  ),
                  trailing: Text('Company Size'),
                  subtitle: Text('Including Employees and Contractors'),
                  title: Text(snapshot.data!.Company_Size),
                ),

                ListTile(
                  leading: Icon(
                    Icons.monetization_on_outlined,
                  ),
                  trailing: Text('Revenue'),
                  subtitle: Text('Yearly'),
                  title: Text(snapshot.data!.Revenue),
                ),

                ListTile(
                  leading: Icon(
                    Icons.money_sharp,
                  ),
                  trailing: Text('Is It Profitable'),
                  subtitle: Text('For the current year'),
                  title: Text(snapshot.data!.Revenue),
                ),

                ListTile(
                  leading: Icon(
                    Icons.monetization_on_outlined,
                  ),
                  trailing: Text('Funds Raised'),
                  subtitle: Text('Using Equity'),
                  title: Text(snapshot.data!.Earlier_Fund_Raised),
                ),

                ListTile(
                  leading: Icon(
                    Icons.branding_watermark_rounded,
                  ),
                  trailing: Text('Existing Liabilities'),
                  subtitle: Text('Majorly Debt'),
                  title: Text(snapshot.data!.Existing_Liabilities),
                ),

                ListTile(
                  leading: Icon(
                    Icons.house_outlined,
                  ),
                  trailing: Text('Parent Company/Holder'),
                  subtitle: Text('Also Onboarded on KuruX'),
                  title: Text(snapshot.data!.Owner),
                ),

                ListTile(
                  leading: Icon(
                    Icons.web,
                  ),
                  trailing: Text('LinkedIn'),
                  subtitle: Text('Online Presence'),
                  title: Text(snapshot.data!.Owner),
                ),

                ListTile(
                  leading: Icon(
                    Icons.web,
                  ),
                  trailing: Text('Pitch Link'),
                  subtitle: Text('Link to Product/Company Pitch'),
                  title: Text(snapshot.data!.Pitch_Link),
                ),

                //adding button

                Container(
                    height: 80,
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        child: Text('Buy ' + snapshot.data!.Ticker_Symbol,
                            textScaleFactor: 1),
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
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
