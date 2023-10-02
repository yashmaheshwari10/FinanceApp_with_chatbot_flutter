import 'package:edi/pages/transacttrial.dart';
import 'package:flutter/material.dart';
import 'addspendd.dart';

class TrasactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bgcolor.png'), fit: BoxFit.fill),
      ),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddSpend()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.home)],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
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
          onPressed: () {},
          child: Icon(Icons.add_circle),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //body

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
            MyTransaction(
                transactionName: 'transactionName',
                money: '300',
                expenseOrIncome: 'income')
          ],
        ),
      ),
    );
  }
}
