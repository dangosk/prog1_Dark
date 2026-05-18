import 'package:flutter/material.dart';
import '../models/student.dart';

class AddStudentScreen extends StatefulWidget {
  final Student? initialStudent; // added

  const AddStudentScreen({super.key, this.initialStudent});
  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _studentNumCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _departmentCtrl = TextEditingController(
    text: 'Management Information Systems',
  );
  final _emailCtrl = TextEditingController();
  final _contributorCtrl = TextEditingController();
  final _gpaCtrl = TextEditingController();
  String _selectedLevel = '400';

  final List<String> _levels = ['100', '200', '300', '400', '500'];

  @override
  void initState() {
    super.initState();

    final s = widget.initialStudent;
    if (s != null) {
      _studentNumCtrl.text = s.studentNumber;
      _nameCtrl.text = s.name;
      _departmentCtrl.text = s.department;
      _gpaCtrl.text = s.gpa.toString();
      _emailCtrl.text = s.email;
      _contributorCtrl.text = s.contributedBy;
      _selectedLevel = s.level;
    }
  }

  @override
  void dispose() {
    _studentNumCtrl.dispose();
    _nameCtrl.dispose();
    _departmentCtrl.dispose();
    _emailCtrl.dispose();
    _contributorCtrl.dispose();
    _gpaCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final student = Student(
      id:
          widget.initialStudent?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      studentNumber: _studentNumCtrl.text.trim(),
      name: _nameCtrl.text.trim(),
      department: _departmentCtrl.text.trim(),
      level: _selectedLevel,
      gpa: double.parse(_gpaCtrl.text.trim()),
      email: _emailCtrl.text.trim(),
      contributedBy: _contributorCtrl.text.trim(),
    );

    Navigator.pop(context, student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialStudent != null ? 'Edit Student' : 'Add Student Record',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _field(
                controller: _studentNumCtrl,
                label: 'Student Number',
                hint: 'e.g. MIS/2021/042',
                icon: Icons.badge,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              _field(
                controller: _nameCtrl,
                label: 'Full Name',
                hint: 'e.g. Chidi Okeke',
                icon: Icons.person,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              _field(
                controller: _departmentCtrl,
                label: 'Department',
                hint: 'Management Information Systems',
                icon: Icons.account_balance,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              _levelDropdown(),
              _field(
                controller: _gpaCtrl,
                label: 'GPA (0.0 – 5.0)',
                hint: 'e.g. 4.2',
                icon: Icons.star,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (v) {
                  final n = double.tryParse(v ?? '');
                  if (n == null) return 'Enter a valid number';
                  if (n < 0 || n > 5) return 'GPA must be between 0 and 5';
                  return null;
                },
              ),
              _field(
                controller: _emailCtrl,
                label: 'Email Address',
                hint: 'e.g. chidi@university.edu.ng',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v == null || !v.contains('@'))
                    ? 'Enter a valid email'
                    : null,
              ),
              _field(
                controller: _contributorCtrl,
                label: 'Your Student Number & Name',
                hint: 'e.g. MIS/2021/042 — Chidi Okeke',
                icon: Icons.edit,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Required — identify yourself'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('Save Record'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }

  Widget _levelDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedLevel,
        decoration: InputDecoration(
          labelText: 'Level',
          prefixIcon: const Icon(Icons.school),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: _levels
            .map((l) => DropdownMenuItem(value: l, child: Text('Level $l')))
            .toList(),
        onChanged: (v) => setState(() => _selectedLevel = v ?? '400'),
      ),
    );
  }
}
