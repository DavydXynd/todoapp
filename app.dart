import 'package:autopage/home.dart';
import 'package:autopage/theme.dart';
import 'package:flutter/material.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Home(),
    );
  }
}
