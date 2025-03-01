import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../utils/grade_utils.dart';
import 'gpa_result_screen.dart';

class SubjectInputScreen extends StatefulWidget {
  const SubjectInputScreen({Key? key}) : super(key: key);

  @override
  _SubjectInputScreenState createState() => _SubjectInputScreenState();
}

class _SubjectInputScreenState extends State<SubjectInputScreen> {
  // Start with only 2 subjects
  final List<Subject> _subjects = [
    Subject(name: '', credits: 0, grade: 'A'),
    Subject(name: '', credits: 0, grade: 'A'),
  ];

  // Start with only 2 controllers
  final List<TextEditingController> _nameControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  
  final List<TextEditingController> _creditControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var controller in _creditControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewSubject() {
    setState(() {
      _subjects.add(Subject(name: '', credits: 0, grade: 'A'));
      _nameControllers.add(TextEditingController());
      _creditControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Subject Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...List.generate(
              _subjects.length,
              (index) => _buildSubjectInput(index),
            ),
            const SizedBox(height: 10),
            // Add subject button
            OutlinedButton.icon(
              onPressed: _addNewSubject,
              icon: const Icon(Icons.add),
              label: const Text('Add Subject'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateGPA,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Calculate GPA',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectInput(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subject ${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Show remove button if there are more than 2 subjects
                if (_subjects.length > 2)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _subjects.removeAt(index);
                        _nameControllers.removeAt(index);
                        _creditControllers.removeAt(index);
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _nameControllers[index],
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _subjects[index].name = value;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _creditControllers[index],
              decoration: const InputDecoration(
                labelText: 'Credit Hours',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _subjects[index].credits = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Grade',
                border: OutlineInputBorder(),
              ),
              value: _subjects[index].grade,
              items: GradeUtils.gradeOptions.map((String grade) {
                return DropdownMenuItem<String>(
                  value: grade,
                  child: Text(grade),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _subjects[index].grade = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _calculateGPA() {
    // Validate input
    bool isValid = true;
    String errorMessage = '';

    for (int i = 0; i < _subjects.length; i++) {
      if (_nameControllers[i].text.isNotEmpty && 
          _creditControllers[i].text.isNotEmpty) {
        _subjects[i].name = _nameControllers[i].text;
        _subjects[i].credits = int.tryParse(_creditControllers[i].text) ?? 0;
      } else if (_nameControllers[i].text.isNotEmpty || 
                _creditControllers[i].text.isNotEmpty) {
        isValid = false;
        errorMessage = 'Please complete all fields for Subject ${i + 1}';
        break;
      }
    }

    // Check if at least one subject is entered
    bool hasAtLeastOneSubject = false;
    for (int i = 0; i < _subjects.length; i++) {
      if (_nameControllers[i].text.isNotEmpty && 
          _creditControllers[i].text.isNotEmpty) {
        hasAtLeastOneSubject = true;
        break;
      }
    }

    if (!hasAtLeastOneSubject) {
      isValid = false;
      errorMessage = 'Please enter at least one subject';
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return;
    }

    // Filter out empty subjects
    final filledSubjects = _subjects.where((subject) => 
        subject.name.isNotEmpty && subject.credits > 0).toList();

    // Navigate to results screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GPAResultScreen(subjects: filledSubjects),
      ),
    );
  }
}