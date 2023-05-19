import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Other_Pages/change_pass_pin.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/Response_Classes/statusLoader.dart';
import 'package:kurux_frontend_prototype/home_page.dart';
import 'package:kurux_frontend_prototype/login_page.dart';

class initialLoadingScreen extends StatefulWidget {
  const initialLoadingScreen({Key? key}) : super(key: key);

  @override
  State<initialLoadingScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<initialLoadingScreen> {
  late Future<String> status;
  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    status = fetchInitialStatus();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: ListView(children: <Widget>[
        ListTile(
          title: const Center(
              child: Text(
            'KuruX Funding Portal Prototype Terms and Conditions',
            textScaleFactor: 2,
          )),
        ),

        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 5.0,
                  maxHeight: 300.0,
                ),
                child: ListView(children: <Widget>[
                  ListTile(
                    title: const Center(
                        child: Text(
                            'Please note that the following terms and conditions outline the use of the finance application prototype KuruX Funding Portal provided by prajjwal@kurux.in and anubhav@kurux.in to you. By accessing and using the Prototype, the User agrees to comply with these terms and conditions:')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '1. Prototype Purpose: The Prototype is solely intended for demonstration and testing purposes. It does not represent a fully functional or commercial application and should not be used for actual financial transactions or sensitive data. The Company Data, User Data is all mocked for Demonstration purposes.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '2. Limited License: KuruX grants the User a limited, non-exclusive, non-transferable, and revocable license to access and use the Prototype solely for evaluation and feedback purposes during the specified testing period.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '3. Confidentiality: The User agrees to maintain the confidentiality of the Prototype and any information provided by KuruX. The User shall not disclose, distribute, or reproduce any part of the Prototype or related materials without prior written consent from KuruX.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '4. Disclaimer of Liability: The Prototype is provided "as is" without any warranty or representation of any kind, whether expressed or implied. KuruX shall not be held liable for any damages, losses, or claims arising from the use of the Prototype or any reliance on its content.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '5. User Feedback: The User may provide feedback, suggestions, or other information related to the Prototype to KuruX. The User acknowledges that KuruX may use such feedback for any purpose without any obligation to the User.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '6. Indemnification: The User agrees to indemnify and hold harmless the KuruX, its officers, employees, and affiliates from any claims, damages, or liabilities arising out of the User use of the Prototype or any violation of these terms and conditions.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '7. Modification and Termination: The Company reserves the right to modify, suspend, or terminate the Prototype at any time without prior notice. The User acknowledges that the Company shall not be liable for any such modifications, suspensions, or terminations.')),
                  ),
                  ListTile(
                    title: const Center(
                        child: Text(
                            '8. Entire Agreement: These terms and conditions constitute the entire agreement between the User and the Company concerning the Prototype and supersede any prior agreements or understandings, whether written or oral.')),
                  ),
                ]))),

        ListTile(
          title: const Center(
              child: Text(
                  'By accessing and using the Prototype, the User acknowledges that they have read, understood, and agreed to be bound by these terms and conditions. If the User does not agree to these terms, they should refrain from accessing or using the Prototype')),
        ),

        FutureBuilder<String>(
          future: status,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Accept Terms and Conditions'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ));
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     const Text('Does not have account?'),
        //     TextButton(
        //       child: const Text(
        //         'Sign Up',
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       onPressed: () {
        //         //signup screen
        //       },
        //     )
        //   ],
        // ),
      ])),
    );
  }
}
