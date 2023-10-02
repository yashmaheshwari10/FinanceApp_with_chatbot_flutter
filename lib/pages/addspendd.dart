import 'dart:ffi';

import 'package:flutter/material.dart';
import 'transactions.dart';

class AddSpend extends StatefulWidget {
  AddSpend({super.key});

  @override
  State<AddSpend> createState() => _AddSpendState();
}

class _AddSpendState extends State<AddSpend> {
  final transactioncontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  bool _isIncome = false;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.home)],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrasactionsPage()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.monetization_on)],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.people)],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.chat)],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newtransaction();
          },
          child: Icon(Icons.add_circle),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              height: 30,
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
                  width: 120,
                ),
                Icon(
                  Icons.monetization_on,
                  size: 35,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '200₹',
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
                  width: 40,
                ),
                Text(
                  'Income: 300₹',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 40,
                ),
                Text('Expence: 100₹',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
