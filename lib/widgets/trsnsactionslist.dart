import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/pages/transacttrial.dart';
import 'package:flutter/material.dart';

class Transactionslist extends StatelessWidget {
  const Transactionslist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: GoogleSheetsApi.currentTransact.length,
        itemBuilder: (context, index) {
          print(index);
          return MyTransaction(
            transactionName: GoogleSheetsApi.currentTransact[index][0],
            money: GoogleSheetsApi.currentTransact[index][1],
            expenseOrIncome: GoogleSheetsApi.currentTransact[index][2],
            date: GoogleSheetsApi.currentTransact[index][3],
            month: GoogleSheetsApi.currentTransact[index][4],
            index: index + 2,
          );
        });
  }
}
