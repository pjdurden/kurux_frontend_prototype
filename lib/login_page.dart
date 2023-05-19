import 'package:flutter/material.dart';
import 'package:kurux_frontend_prototype/Other_Pages/change_pass_pin.dart';
import 'package:kurux_frontend_prototype/Response_Classes/auth_apis.dart';
import 'package:kurux_frontend_prototype/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Form(
              key: _formKey,
              // padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'KuruX Funding Portal',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User ID',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

                            // bool authStatus = authExec(
                            //     nameController.text, passwordController.text);

                            Future<loginResponse> authStat = tryAuth(
                                nameController.text, passwordController.text);

                            authStat.then((data) {
                              if (data.Auth) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Auth Success')),
                                // );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                        title: 'KuruX Funding Portal',
                                        user_id: nameController.text),
                                  ),
                                );

                                // Navigator.pushNamed(
                                //   context, '/home',
                                //   arguments: String( nameController.text )
                                // );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Auth Failure')),
                                );
                              }
                            }, onError: (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Server Error')),
                              );
                            });

                            //creating a future builer here
                            // FutureBuilder(
                            //   future: authtry,
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       if (snapshot.data!.Auth) {
                            //         return ScaffoldMessenger.of(context).showSnackBar(
                            //           const SnackBar(content: Text('Auth Success')),
                            //         );
                            //       } else {
                            //         return ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(
                            //               content: Text(
                            //                   'Auth Failure${snapshot.data!.AuthResponse}')),
                            //         );
                            //       }
                            //     } else {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         const SnackBar(content: Text('Server Error')),
                            //       );
                            //     }
                            //   },
                            // );

                            // print(nameController.text);
                            // print(passwordController.text);
                          }
                        },
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const change_pass_pin(Type: 'Password'),
                              ),
                            );
                          },
                          child: const Text(
                            'Change Password',
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //forgot password screen

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const change_pass_pin(Type: 'PIN'),
                              ),
                            );
                          },
                          child: const Text(
                            'Change PIN',
                          ),
                        ),
                      ]),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const ListTile(
                        title: Center(child: Text('Forgot Password?')),
                        subtitle: Center(
                            child: Text(
                                'Contact prajjwal@kurux.in or anubhav@kurux.in')),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}
