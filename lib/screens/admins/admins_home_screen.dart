import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CalledStudentsListScreen extends StatefulWidget {
  final bool isEnglish;

  CalledStudentsListScreen({required this.isEnglish});

  @override
  _CalledStudentsListScreenState createState() => _CalledStudentsListScreenState();
}

class _CalledStudentsListScreenState extends State<CalledStudentsListScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('called_students');
  List<Map<String, dynamic>> calledStudents = [];

  @override
  void initState() {
    super.initState();
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map<dynamic, dynamic>);
        setState(() {
          calledStudents = data.values.map((value) => Map<String, dynamic>.from(value)).toList();
        });
      }
    });
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
      body: calledStudents.isEmpty
          ? Center(
              child: Text(
                widget.isEnglish ? 'There is no students requested' : 'لا يوجد طلاب مطلوبون',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: calledStudents.length,
              itemBuilder: (context, index) {
                final student = calledStudents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      student['name'],
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                    subtitle: Text(
                      student['classNumber'],
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
