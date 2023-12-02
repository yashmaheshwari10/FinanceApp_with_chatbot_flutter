import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:edi/navigation/bottomnavbar.dart';
import 'package:edi/Auth/googlesheet_api.dart';

class MyTransaction extends StatefulWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  final String date;
  final String month;
  final int index;
  MyTransaction({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.date,
    required this.month,
    required this.index,
  });

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  final _textcontrollerAMOUNT = TextEditingController();

  final _textcontrollerITEM = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction(int index) {
    DateTime now = DateTime.now();
    String date = now.day.toString();
    String month = now.month.toString();

    GoogleSheetsApi.update(
      index,
      value,
      _textcontrollerAMOUNT.text,
      _isIncome,
      date,
      month,
    );
    setState(() {});
  }

  List items = [
    'Food',
    'Housing',
    'Entertainment',
    'Luxary',
    'Studies',
    'Investments',
    'Other'
  ];
  late String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 9.0, right: 9.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: (context) {
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                              if (text == null ||
                                                  text.isEmpty) {
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
                                        onChanged: (newValue) {
                                          setState() {
                                            value = newValue.toString();
                                          }
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
                                child: Text('Cancel',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              MaterialButton(
                                color: Colors.grey[600],
                                child: Text('Enter',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _enterTransaction(widget.index);
                                    Navigator.of(context).pop();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      );
                    });
              },
              icon: Icons.edit,
              label: 'Edit',
              backgroundColor: Colors.blue,
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            )
          ]),
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[500]),
                      child: Center(
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.transactionName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${widget.date} - ${widget.month} -2023',
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.expenseOrIncome == 'expense'
                              ? Colors.red
                              : Colors.green,
                        )),
                  ],
                ),
                Text(
                  (widget.expenseOrIncome == 'expense' ? '-' : '+') +
                      '\$' +
                      widget.money,
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: widget.expenseOrIncome == 'expense'
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
