import 'package:flutter/material.dart';

class GradeUtils {
  static final List<String> gradeOptions = [
    'A+', 'A', 'A-', 'B+', 'B', 'B-', 
    'C+', 'C', 'C-', 'D+', 'D', 'E'
  ];

  static double getGradePointValue(String grade) {
    switch (grade) {
      case 'A+': return 4.0;
      case 'A': return 4.0;
      case 'A-': return 3.7;
      case 'B+': return 3.3;
      case 'B': return 3.0;
      case 'B-': return 2.7;
      case 'C+': return 2.3;
      case 'C': return 2.0;
      case 'C-': return 1.7;
      case 'D+': return 1.3;
      case 'D': return 1.0;
      case 'E': return 0.7;
      default: return 0.0;
    }
  }

  static Color getGPAColor(double gpa) {
    if (gpa >= 3.7) return Colors.green;
    if (gpa >= 3.0) return Colors.blue;
    if (gpa >= 2.0) return Colors.orange;
    return Colors.red;
  }
}