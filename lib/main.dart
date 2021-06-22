import 'package:clock_app/clock.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock',
      debugShowCheckedModeBanner: false,
      home: Clock()
    );
  }
}