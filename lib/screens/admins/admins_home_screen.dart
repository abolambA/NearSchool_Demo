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
                widget.isEnglish ? 'There is no students requested' : 'لا يوجد طلاب مطلوبون',
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
