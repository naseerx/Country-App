
import 'package:country/screens/country_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country knowledge',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const CountryListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


