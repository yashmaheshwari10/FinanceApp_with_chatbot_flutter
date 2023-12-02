import 'dart:async';

import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/pages/transacttrial.dart';
import 'package:edi/widgets/loading_circle.dart';
import 'package:edi/widgets/trsnsactionslist.dart';
import 'package:flutter/material.dart';
import 'addspendd.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
            SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh)),
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
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                        child: GoogleSheetsApi.loading == true
                            ? LoadingCircle()
                            : Transactionslist()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
