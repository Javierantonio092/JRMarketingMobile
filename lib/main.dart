import 'package:flutter/material.dart';
import 'views/Inicio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Inicio(),
        ),
      ),
    );
  }
}
