import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/pages/addspendd.dart';
import 'package:edi/pages/chatbotpage.dart';
import 'package:edi/pages/transactions.dart';
import 'package:flutter/material.dart';

class Navigationpage extends StatefulWidget {
  const Navigationpage({super.key});

  @override
  State<Navigationpage> createState() => _NavigationpageState();
}

class _NavigationpageState extends State<Navigationpage> {
  Object? value;

  int tab = 0;
  Widget CurrentScreen = AddSpend();
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    DateTime now = DateTime.now();
    String date = now.day.toString();
    String month = now.month.toString();

    GoogleSheetsApi.insert(
      value.toString(),
      _textcontrollerAMOUNT.text,
      _isIncome,
      date,
      month,
    );
    setState(() {});
  }

  List items = [
    'enter transaction',
    'Food',
    'Housing',
    'Entertainment',
    'Luxary',
    'Studies',
    'Investments',
    'Other'
  ];

  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: Text('N E W  T R A N S A C T I O N'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: DropdownButton(
                            hint: Text('What for?'),
                            value: value,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  value = newValue;
                                },
                              );
                            },
                            items: items.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                        Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: CurrentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newTransaction,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 11,
          child: Container(
            color: Colors.grey[900],
            height: 60,
            child: Column(
              children: [
                SizedBox(height: 1.5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MaterialButton(
                              onPressed: (() {
                                setState(() {
                                  CurrentScreen = AddSpend();
                                  tab = 0;
                                });
                              }),
                              child: Column(children: [
                                Icon(
                                  Icons.home,
                                  color: tab == 0 ? Colors.blue : Colors.white,
                                  size: 25,
                                ),
                                Text(
                                  'home',
                                  style: TextStyle(
                                    color:
                                        tab == 0 ? Colors.blue : Colors.white,
                                  ),
                                )
                              ]),
                            ),
                            MaterialButton(
                              onPressed: (() {
                                setState(() {
                                  CurrentScreen = TrasactionsPage();
                                  tab = 1;
                                });
                              }),
                              child: Column(children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: tab == 1 ? Colors.blue : Colors.white,
                                  size: 25,
                                ),
                                Text(
                                  'trasactions',
                                  style: TextStyle(
                                    color:
                                        tab == 1 ? Colors.blue : Colors.white,
                                  ),
                                )
                              ]),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            MaterialButton(
                              onPressed: (() {
                                setState(() {
                                  CurrentScreen =
                                      SingleChildScrollView(child: AddSpend());
                                  tab = 2;
                                });
                              }),
                              child: Column(children: [
                                Icon(
                                  Icons.monetization_on,
                                  color: tab == 2 ? Colors.blue : Colors.white,
                                  size: 25,
                                ),
                                Text(
                                  'family',
                                  style: TextStyle(
                                    color:
                                        tab == 2 ? Colors.blue : Colors.white,
                                  ),
                                )
                              ]),
                            ),
                            MaterialButton(
                              onPressed: (() {
                                setState(() {
                                  CurrentScreen = ChatPage();
                                  tab = 3;
                                });
                              }),
                              child: Column(children: [
                                Icon(
                                  Icons.chat,
                                  color: tab == 3 ? Colors.blue : Colors.white,
                                  size: 25,
                                ),
                                Text(
                                  'chatbot',
                                  style: TextStyle(
                                    color:
                                        tab == 3 ? Colors.blue : Colors.white,
                                  ),
                                )
                              ]),
                            )
                          ],
                        ),
                      )
                    ]),
              ],
            ),
          )),
    );
  }
}
