import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentCard({super.key, required this.student, required this.onTap});

  Color _gpaColor(double gpa) {
    if (gpa >= 4.5) return Colors.green;
    if (gpa >= 3.5) return Colors.blue;
    if (gpa >= 2.5) return Colors.orange;
    return Colors.red;
  }

  // ignore: unused_element
  String _gpaLabel(double gpa) {
    if (gpa >= 4.5) return 'S Class';
    if (gpa >= 3.5) return 'First Class';
    if (gpa >= 2.4) return 'Second Class';
    if (gpa >= 1.5) return 'Third Class';
    return 'Pass';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Text(
            student.name.isNotEmpty ? student.name[0].toUpperCase() : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          student.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${student.studentNumber} • ${student.department}'),
        trailing: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            Text(
              'GPA: ${student.gpa.toStringAsFixed(1)}',
              style: TextStyle(
                color: _gpaColor(student.gpa),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Level ${student.level}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Container(
              //added
              margin: const EdgeInsets.only(top: 5, left: 5),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: _gpaColor(student.gpa).withValues(alpha: .15),
                color: _gpaColor(student.gpa).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: _gpaColor(student.gpa), width: 0.8),
              ),
              child: Text(
                _gpaLabel(student.gpa),
                style: TextStyle(
                  fontSize: 8,
                  color: _gpaColor(student.gpa),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
