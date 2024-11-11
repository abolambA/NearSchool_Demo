import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class StudentInfoScreen extends StatefulWidget {
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
  _StudentInfoScreenState createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  bool _isWaiting = false;
  bool _receivedOptionsVisible = false;

  void _callStudent() {
    FirebaseFirestore.instance.collection('called_students').doc(widget.name).set({
      'name': widget.name,
      'grade': widget.grade,
      'section': widget.section,
      'status': 'called',
    });

    setState(() {
      _isWaiting = true;
    });

    // Wait for 2 minutes before showing "Received" and "Not Received" buttons
    Timer( Duration(minutes: 1), () {
      setState(() {
        _isWaiting = false;
        _receivedOptionsVisible = true;
      });
    });
  }

  void _handleResponse(bool received) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(received ? (widget.isEnglish ? 'Student Received' : 'تم استلام الطالب') : (widget.isEnglish ? 'Student Not Received' : 'لم يتم استلام الطالب')),
          content: Text(received ? (widget.isEnglish ? 'You have received your student.' : 'لقد استلمت الطالب.') : (widget.isEnglish ? 'You have not received your student. The Admin is going to be alerted ' : ' لم تستلم الطالب. سيتم إعلام المشرف بهذا')),
          actions: <Widget>[
            TextButton(
              child: Text(widget.isEnglish ? 'OK' : 'حسنا'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to student list screen
              },
            ),
          ],
        );
      },
    );
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
          widget.isEnglish ? 'Student - ${widget.name}' : 'طالب - ${widget.name}',
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
                widget.grade,
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              SizedBox(height: 16.0),
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
                      '${widget.isEnglish ? 'Student Name:' : 'اسم الطالب:'} ${widget.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '${widget.isEnglish ? 'Section:' : 'الصف:'} ${widget.section}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              if (_isWaiting)
                CircularProgressIndicator()
              else if (_receivedOptionsVisible)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleResponse(true),
                      child: Text(
                        widget.isEnglish ? 'Received' : 'تم الاستلام',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _handleResponse(false),
                      child: Text(
                        widget.isEnglish ? 'Not Received' : 'لم يتم الاستلام',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: _callStudent,
                  child: Text(
                    widget.isEnglish ? 'Call Student' : 'استدعاء الطالب',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
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
