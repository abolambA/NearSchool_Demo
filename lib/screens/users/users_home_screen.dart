import 'package:flutter/material.dart';
import 'student_screen.dart';

class UsersHomeScreen extends StatelessWidget {
  final bool isEnglish;

  UsersHomeScreen({required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEnglish ? 'Students list' : 'قائمة الطلاب',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue.shade900),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          StudentTile(
            name: isEnglish ? 'Kamel Abdel Razaq Al-Rifai' : 'كامل عبد الرزاق الرفاعي',
            classNumber: '10-3',
            isEnglish: isEnglish,
          ),
          StudentTile(
            name: isEnglish ? 'Mohammed Nihad Al-Soufi' : 'محمد نهاد الصوفي',
            classNumber: '10-6',
            isEnglish: isEnglish,
          ),
          StudentTile(
            name: isEnglish ? 'Mohammed Emad Al-Soufi' : 'محمد عماد الصوفي',
            classNumber: '7-2',
            isEnglish: isEnglish,
          ),
          StudentTile(
            name: isEnglish ? 'Bashir Al-Rifai' : 'بشير الرفاعي',
            classNumber: '2-1',
            isEnglish: isEnglish,
          ),
        ],
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  final String name;
  final String classNumber;
  final bool isEnglish;

  StudentTile({required this.name, required this.classNumber, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          name,
          textAlign: isEnglish ? TextAlign.left : TextAlign.right,
          style: TextStyle(color: Colors.blue.shade900),
        ),
        subtitle: Text(
          classNumber,
          textAlign: isEnglish ? TextAlign.left : TextAlign.right,
          style: TextStyle(color: Colors.blue.shade900),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.blue.shade900),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentInfoScreen(
                name: name,
                classNumber: classNumber,
                isEnglish: isEnglish,
              ),
            ),
          );
        },
      ),
    );
  }
}
