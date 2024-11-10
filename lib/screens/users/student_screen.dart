import 'package:flutter/material.dart';

class StudentInfoScreen extends StatelessWidget {
  final String name;
  final String classNumber;
  final bool isEnglish;

  StudentInfoScreen({required this.name, required this.classNumber, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pop(context); // Takes the user back to the previous screen
          },
        ),
        title: Text(
          isEnglish ? 'Student Information' : 'معلومات الطالب',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classNumber,
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 16.0),
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
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade900,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: () {
                // Handle send student action
              },
              icon: Icon(Icons.campaign, color: Colors.white),
              label: Text(isEnglish ? 'Call Student' : 'نداء الطالب'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
