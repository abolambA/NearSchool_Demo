import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final bool isEnglish;

  AboutScreen({required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isEnglish ? 'Demo App' : 'تطبيق إستعراض',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.language, color: Colors.blue.shade900), // Fixed icon for consistency
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isEnglish ? 'About the application' : 'عن التطبيق',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              isEnglish
                  ? 'This application was built by the student: Mohammad Nihad AlSafe to link the internal and external environment of the school and to facilitate the vital operations in the school day and to increase the safety rate for school students and for a bright future full of innovation'
                  : 'تم بناء هذا التطبيق من قبل الطالب: محمد نهاد الصوفي للربط بين البيئة الداخلية و الخارجية للمدرسة و لتسهيل العمليات الحيوية في اليوم الدراسي و لزيادة نسبة الأمان للطلاب المدرسيين و لمستقبل باهر يدخل بالإبتكار',
              style: TextStyle(fontSize: 16, color: Colors.blue.shade900),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
