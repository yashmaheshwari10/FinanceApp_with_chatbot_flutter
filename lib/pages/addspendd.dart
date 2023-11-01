import 'dart:ffi';

import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'transactions.dart';
import 'dart:async';

class AddSpend extends StatefulWidget {
  AddSpend({super.key});

  @override
  State<AddSpend> createState() => _AddSpendState();
}

class _AddSpendState extends State<AddSpend> {
  final transactioncontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  bool _isIncome = false;
  double income = GoogleSheetsApi.calculateincome();
  double expense = GoogleSheetsApi.calculateexpence();
  bool timerHasStarted = false;

  void newtransaction() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                  title: Text(
                    'Add Transaction',
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Expence'),
                            Switch(
                                value: _isIncome,
                                onChanged: (newvalue) {
                                  setState(() {
                                    _isIncome = newvalue;
                                  });
                                }),
                            Text('Income'),
                          ],
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                          hintText: 'Amount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )),
                      ],
                    ),
                  ));
              ;
            },
          );
        });
  }

  void refresh() {
    setState(() {});
  }

  bool load = false;

  List<double> monthlyExp = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  void calcexpences() {
    for (int i = 0; i <= 31; i++) {
      print(i);
      setState(() {
        monthlyExp[i] = GoogleSheetsApi.calculateMonthlyTransact(i.toString());
      });
    }
  }

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    calcexpences();
    double balance = income - expense;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // bottomNavigationBar: BottomAppBar(
        //   shape: CircularNotchedRectangle(),
        //   notchMargin: 10,
        //   child: Container(
        //     height: 60,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             MaterialButton(
        //               onPressed: () {},
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [Icon(Icons.home)],
        //               ),
        //             ),
        //             MaterialButton(
        //               onPressed: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => TrasactionsPage()));
        //               },
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [Icon(Icons.monetization_on)],
        //               ),
        //             ),
        //             SizedBox(
        //               width: 40,
        //             ),
        //             MaterialButton(
        //               onPressed: () {},
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [Icon(Icons.people)],
        //               ),
        //             ),
        //             MaterialButton(
        //               onPressed: () {},
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [Icon(Icons.chat)],
        //               ),
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     newtransaction();
        //   },
        //   child: Icon(Icons.add_circle),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 130,
                ),
                Text(
                  'Grow More',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                Icon(
                  Icons.attach_money_sharp,
                  size: 40,
                  color: Colors.lightGreen.shade50,
                ),
                Text(
                  'This months spend:-',
                  style:
                      TextStyle(fontSize: 24, color: Colors.lightGreen.shade50),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                Icon(
                  Icons.monetization_on,
                  size: 35,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 20,
                ),
                GoogleSheetsApi.loading == true
                    ? LoadingCircle()
                    : Text(
                        GoogleSheetsApi.calculatebalance().toString(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Income: ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  GoogleSheetsApi.calculateincome().toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 40,
                ),
                Text('Expence: ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Text(
                  GoogleSheetsApi.calculateexpence().toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Weekly Spend",
              style: TextStyle(fontSize: 26),
            ),
          ],
        ),
      ),
    );
  }
}
