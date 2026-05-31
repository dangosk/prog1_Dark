import 'package:flutter/material.dart';
import '../data/students_data.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final students = sampleStudents;

    // Average GPA
    final avgGpa = students.isEmpty
        ? 0.0
        : students.map((s) => s.gpa).reduce((a, b) => a + b) / students.length;

    // Highest GPA Student
    final topStudent = students.reduce((a, b) => a.gpa > b.gpa ? a : b);

    // Lowest GPA Student
    final lowStudent = students.reduce((a, b) => a.gpa < b.gpa ? a : b);

    // Students per level
    final Map<String, int> levelCounts = {};

    for (var student in students) {
      levelCounts[student.level] = (levelCounts[student.level] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('GPA Statistics Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatCard(
              title: 'Class Average GPA',
              value: avgGpa.toStringAsFixed(2),
              icon: Icons.bar_chart,
              color: Colors.indigo,
            ),

            const SizedBox(height: 12),

            _buildStatCard(
              title: 'Highest GPA',
              value:
                  '${topStudent.name} (${topStudent.gpa.toStringAsFixed(2)})',
              icon: Icons.emoji_events,
              color: Colors.green,
            ),

            const SizedBox(height: 12),

            _buildStatCard(
              title: 'Lowest GPA',
              value:
                  '${lowStudent.name} (${lowStudent.gpa.toStringAsFixed(2)})',
              icon: Icons.warning_amber_rounded,
              color: Colors.red,
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.groups, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text(
                          'Students Per Level',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...levelCounts.entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Level ${entry.key}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '${entry.value} student(s)',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
