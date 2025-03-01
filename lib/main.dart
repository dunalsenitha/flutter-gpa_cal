import 'package:flutter/material.dart';
import 'screens/subject_input_screen.dart';

void main() {
  runApp(const GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue, // Light blue primary color
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlueAccent), // Light blue accent color
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue, // Light blue button background
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(3, 169, 244, 1), // Light blue button border
            side: const BorderSide(color: Colors.lightBlue),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue, // Light blue app bar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      home: const SubjectInputScreen(),
    );
  }
}
