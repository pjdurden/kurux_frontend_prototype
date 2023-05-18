// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'home_page.dart';

List<BottomNavigationBarItem> bottomBar() {
  List<BottomNavigationBarItem> temp = <BottomNavigationBarItem>[];

  temp.add(const BottomNavigationBarItem(
    icon: Icon(Icons.account_balance_outlined),
    label: 'Companies',
  ));

  temp.add(const BottomNavigationBarItem(
    icon: Icon(Icons.checklist_outlined),
    label: 'My Portfolio',
  ));

  temp.add(const BottomNavigationBarItem(
    icon: Icon(Icons.account_balance_wallet_outlined),
    label: 'My Orders',
  ));

  return temp;
}

void onTabTapped(BuildContext context, int index, String user_id) {
  if (index > 0) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MyHomePage(title: 'KuruX Funding Portal', user_id: user_id),
      ),
    );
  }
}



//  BottomNavigationBarItem(
//   items: const <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.account_balance_outlined),
//       label: 'Companies',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.checklist_outlined),
//       label: ' My Portfolio',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.account_balance_wallet_outlined),
//       label: 'Wallet',
//     ),
//   ], required String label, required Icon icon,
// );
