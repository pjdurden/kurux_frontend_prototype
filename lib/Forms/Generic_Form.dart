// import 'package:flutter/material.dart';

// // Create a Form widget.
// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});

//   final List<String> forms = <String>[];

//   MyCustomForm(List<String> formsNeeded) {
//     forms = formsNeeded;
//   }

//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// // Create a corresponding State class.
// // This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a GlobalKey<FormState>,
//   // not a GlobalKey<MyCustomFormState>.
//   List<TextEditingController> formFields = <TextEditingController>[];

//   final _formKey = GlobalKey<FormState>();

//   MyCustomFormState(List<String> formsneeded) {
//     List<TextEditingController> temp = <TextEditingController>[];

//     formFields = temp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Scaffold(
//       body: Padding(
//           padding: const EdgeInsets.all(10),
//           child: ListView(
//             children: <Widget>[
//               Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'KuruX Funding Portal',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 30),
//                   )),
//               Container(
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(10),
//                   child: const Text(
//                     'Sign in',
//                     style: TextStyle(fontSize: 20),
//                   )),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'User Name',
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                 child: TextField(
//                   obscureText: true,
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Password',
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   //forgot password screen
//                 },
//                 child: const Text(
//                   'Forgot Password',
//                 ),
//               ),
//               Container(
//                   height: 50,
//                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: ElevatedButton(
//                     child: const Text('Login'),
//                     onPressed: () {
//                       print(nameController.text);
//                       print(passwordController.text);
//                     },
//                   )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text('Does not have account?'),
//                   TextButton(
//                     child: const Text(
//                       'Sign in',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     onPressed: () {
//                       //signup screen
//                     },
//                   )
//                 ],
//               ),
//             ],
//           )),
//     );
//   }
// }
