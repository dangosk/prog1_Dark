import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() { 
  runApp(const StudentRecordApp()); 
} 

class StudentRecordApp extends StatefulWidget { 
  const StudentRecordApp({super.key}); 
  @override 
  State<StudentRecordApp> createState() => _StudentRecordAppState(); 
} 

 
class _StudentRecordAppState extends State<StudentRecordApp> { 
  ThemeMode _themeMode = ThemeMode.light; 
  @override 
  void initState() { 
    super.initState(); 
    _loadTheme(); 
  } 
  Future<void> _loadTheme() async { 
    final prefs = await SharedPreferences.getInstance(); 
    final isDark = prefs.getBool('darkMode') ?? false; 
    setState(() { 
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light; 
    }); 
  } 
  Future<void> toggleTheme() async { 
    final prefs = await SharedPreferences.getInstance(); 
    setState(() { 
      _themeMode = 
          _themeMode == ThemeMode.dark 
              ? ThemeMode.light 
              : ThemeMode.dark; 
    }); 
   await prefs.setBool( 
      'darkMode', 
      _themeMode == ThemeMode.dark, 
    ); 
  } 

 

  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      themeMode: _themeMode, 
      theme: ThemeData( 
        brightness: Brightness.light, 
        colorSchemeSeed: Colors.indigo, 
        useMaterial3: true, 
      ), 

      darkTheme: ThemeData( 
        brightness: Brightness.dark, 
        colorSchemeSeed: Colors.indigo, 
        useMaterial3: true, 
      ), 

 

      home: HomeScreen( 
        onToggleTheme: toggleTheme, 
        isDarkMode: _themeMode == ThemeMode.dark, 
      ), 

    ); 

  } 

} 
