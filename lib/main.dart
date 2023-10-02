import 'package:edi/Auth/googlesheet_api.dart';
import 'package:edi/pages/addspendd.dart';
import 'package:edi/pages/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gsheets/gsheets.dart';

const spreadsheetid = '1ByNKMtSmRaQ3XtijBLP4hFwmyVhIbwhqx-4e1NdZkZ4';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.ralewayTextTheme(
        Theme.of(context).textTheme,
      )),
      home: AddSpend(),
    );
  }
}
