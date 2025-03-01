import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../utils/grade_utils.dart';

class GPAResultScreen extends StatelessWidget {
  final List<Subject> subjects;

  const GPAResultScreen({Key? key, required this.subjects}) : super(key: key);

  double _calculateGPA() {
    double totalGradePoints = 0;
    int totalCredits = 0;

    for (var subject in subjects) {
      double gradePoint = GradeUtils.getGradePointValue(subject.grade);
      totalGradePoints += (gradePoint * subject.credits);
      totalCredits += subject.credits;
    }

    if (totalCredits == 0) return 0;
    return totalGradePoints / totalCredits;
  }

  @override
  Widget build(BuildContext context) {
    final gpa = _calculateGPA();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Your GPA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      gpa.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: GradeUtils.getGPAColor(gpa),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Subject Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DataTable(
              columns: const [
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Credits')),
                DataColumn(label: Text('Grade')),
                DataColumn(label: Text('Points')),
              ],
              rows: subjects.map((subject) {
                double gradePoint = GradeUtils.getGradePointValue(subject.grade);
                double subjectPoints = gradePoint * subject.credits;
                
                return DataRow(cells: [
                  DataCell(Text(subject.name)),
                  DataCell(Text(subject.credits.toString())),
                  DataCell(Text(subject.grade)),
                  DataCell(Text(subjectPoints.toStringAsFixed(2))),
                ]);
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Calculate Another GPA',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}