import 'dart:async';

import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/pages/transacttrial.dart';
import 'package:edi/widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'addspendd.dart';

class TrasactionsPage extends StatefulWidget {
  const TrasactionsPage({super.key});

  @override
  State<TrasactionsPage> createState() => _TrasactionsPageState();
}

class _TrasactionsPageState extends State<TrasactionsPage> {
  bool timerHasStarted = false;

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
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bgcolor.png'), fit: BoxFit.fill),
      ),
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
        //               onPressed: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => AddSpend()));
        //               },
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [Icon(Icons.home)],
        //               ),
        //             ),
        //             MaterialButton(
        //               onPressed: () {},
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
        //   onPressed: () {},
        //   child: Icon(Icons.add_circle),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //body
        appBar: AppBar(
          title: Row(
            children: [
              Center(),
              SizedBox(
                width: 100,
              ),
              Icon(Icons.monetization_on),
              Text(
                "Transactions",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        body: Column(
          children: [
            // Card(
            //   child: SizedBox(
            //     height: 40,
            //     width: 200,
            //   ),
            // ),
            SizedBox(
              height: 60,
            ),

            SizedBox(
              height: 10,
            ),
            // MyTransaction(
            //     transactionName: 'transactionName',
            //     money: '300',
            //     expenseOrIncome: 'income'),
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
                            : ListView.builder(
                                itemCount:
                                    GoogleSheetsApi.currentTransact.length,
                                itemBuilder: (context, index) {
                                  return MyTransaction(
                                    transactionName: GoogleSheetsApi
                                        .currentTransact[index][0],
                                    money: GoogleSheetsApi
                                        .currentTransact[index][1],
                                    expenseOrIncome: GoogleSheetsApi
                                        .currentTransact[index][2],
                                    date: GoogleSheetsApi.currentTransact[index]
                                        [3],
                                    month: GoogleSheetsApi
                                        .currentTransact[index][4],
                                  );
                                }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
