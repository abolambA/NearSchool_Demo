import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalledStudentsListScreen extends StatefulWidget {
  final bool isEnglish;

  CalledStudentsListScreen({required this.isEnglish});

  @override
  _CalledStudentsListScreenState createState() => _CalledStudentsListScreenState();
}

class _CalledStudentsListScreenState extends State<CalledStudentsListScreen> {
  final CollectionReference _calledStudentsCollection = FirebaseFirestore.instance.collection('called_students');

  // Navigate to the student screen
  void _navigateToStudentScreen(BuildContext context, Map<String, dynamic> studentData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentInfoScreen(
          name: studentData['name'],
          grade: studentData['grade'],
          section: studentData['section'],
          isEnglish: widget.isEnglish,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isEnglish ? 'Called Students list' : 'قائمة الطلاب المطلوبة',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _calledStudentsCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                widget.isEnglish ? 'There are no students requested' : 'لا يوجد طلاب مطلوبون',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          final calledStudents = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: calledStudents.length,
            itemBuilder: (context, index) {
              final studentData = calledStudents[index].data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    studentData['name'] ?? 'Unknown',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  subtitle: Text(
                    '${studentData['grade'] ?? 'Unknown'} - ${studentData['section'] ?? 'Unknown'}',
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: Colors.blue.shade900,
                  ),
                  onTap: () => _navigateToStudentScreen(context, studentData),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StudentInfoScreen extends StatelessWidget {
  final String name;
  final String grade;
  final String section;
  final bool isEnglish;

  StudentInfoScreen({
    required this.name,
    required this.grade,
    required this.section,
    required this.isEnglish,
  });

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                grade,
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
                          '${isEnglish ? 'Section:' : 'الصف:'} $section',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
