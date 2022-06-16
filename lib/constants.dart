import 'package:flutter/material.dart';

const appBarTheme = AppBarTheme(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.black),
  titleTextStyle: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 25,
  ),
);

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: Colors.grey.shade200,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade200, width: 0.0),
  ),
);
