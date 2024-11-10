import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentInfoScreen extends StatelessWidget {
  final String name;
  final String classNumber;
  final bool isEnglish;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  StudentInfoScreen({
    required this.name,
    required this.classNumber,
    required this.isEnglish,
  });

  void _callStudent() {
    _database.child('called_students').push().set({
      'name': name,
      'classNumber': classNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isEnglish ? name : name,
          style: TextStyle(color: Colors.blue.shade900),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center( // Center the body content vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              // Displaying class number in large text
              Text(
                classNumber,
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 16.0),
              // Stack for holding student info and placing the avatar outside it
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${isEnglish ? 'Student Name:' : 'اسم الطالب:'} $name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${isEnglish ? 'Section:' : 'الصف:'} $classNumber',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Position the avatar outside the card, on top-right
                ],
              ),
              SizedBox(height: 24.0),
              // Call student button with wider padding
              ElevatedButton.icon(
                onPressed: _callStudent,
                icon: Icon(Icons.campaign, color: Colors.white),
                label: Text(
                  isEnglish ? 'Call Student' : 'نداء الطالب',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0), // Increased horizontal padding
                  textStyle: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
