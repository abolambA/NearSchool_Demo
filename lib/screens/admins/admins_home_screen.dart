import 'package:flutter/material.dart';
import 'package:near_school_demo/screens/home_screen.dart';

class CalledStudentsListScreen extends StatelessWidget {
  final bool isEnglish;

  CalledStudentsListScreen({required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
        title: Text(
          isEnglish ? 'Called Students list' : 'قائمة الطلاب المطلوبة',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.blue.shade900),
            onPressed: () {
              // Optional: Implement language switching here if needed.
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          isEnglish ? 'There is no students requested' : 'لا يوجد طلاب مطلوبون',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.blue.shade900,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
                blurRadius: 3,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
