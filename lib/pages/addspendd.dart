import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/bar_graph/bar_graph.dart';
import 'package:edi/widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'transactions.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:quiver/time.dart';

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
  double maxYgraph = 0;
  var date = DateTime.now();

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
        if (monthlyExp[i] > maxYgraph) {
          setState(() {
            maxYgraph = monthlyExp[i];
          });
        }
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
    print(date.weekday);
    int monday = date.day - date.weekday;
    if (monday < 0) {
      int monthdays = daysInMonth(date.year, date.month - 1);
      monday = (monthdays - date.day) + date.day - 1;
    }
    int tuesday = monday + 1;
    if (tuesday > daysInMonth(date.year, date.month - 1)) {
      tuesday = tuesday - daysInMonth(date.year, date.month - 1);
    }
    int wednesday = monday + 2;
    if (wednesday > daysInMonth(date.year, date.month - 1)) {
      wednesday = wednesday - daysInMonth(date.year, date.month - 1);
    }
    int thursday = monday + 3;
    if (thursday > daysInMonth(date.year, date.month - 1)) {
      thursday = thursday - daysInMonth(date.year, date.month - 1);
    }
    int friday = monday + 4;
    if (friday > daysInMonth(date.year, date.month - 1)) {
      friday = friday - daysInMonth(date.year, date.month - 1);
    }
    int saturday = monday + 5;
    if (saturday > daysInMonth(date.year, date.month - 1)) {
      saturday = saturday - daysInMonth(date.year, date.month - 1);
    }
    int sunday = monday + 6;
    if (sunday > daysInMonth(date.year, date.month - 1)) {
      sunday = sunday - daysInMonth(date.year, date.month - 1);
    }
    print(monday);
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    calcexpences();
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
            Row(
              children: [
                SizedBox(
                  width: 110,
                ),
                Text(
                  "Weekly Spend",
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(onPressed: calcexpences, icon: Icon(Icons.refresh))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 230,
              child: GoogleSheetsApi.loading == true
                  ? LoadingCircle()
                  : BarGraph(
                      maxY: maxYgraph,
                      monday: monday,
                      tuesday: tuesday,
                      wednesday: wednesday,
                      thursday: thursday,
                      friday: friday,
                      sat: saturday,
                      sun: sunday,
                      weeklysummary: [
                        monthlyExp[monday],
                        monthlyExp[tuesday],
                        monthlyExp[wednesday],
                        monthlyExp[thursday],
                        monthlyExp[friday],
                        monthlyExp[saturday],
                        monthlyExp[sunday],
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
