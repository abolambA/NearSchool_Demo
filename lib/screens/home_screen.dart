import 'package:flutter/material.dart';
import 'package:near_school_demo/screens/about_screen.dart';
import 'package:near_school_demo/screens/admins/admins_home_screen.dart';
import 'package:near_school_demo/screens/users/users_home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.info, color: Colors.blue.shade900),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutScreen(isEnglish: isEnglish),
              ),
            );
          },
        ),
        title: Text(
          isEnglish ? 'Demo App' : 'تطبيق إستعراض',
          style: TextStyle(color: Colors.blue.shade900),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.language, color: Colors.blue.shade900),
            onPressed: () {
              setState(() {
                isEnglish = !isEnglish;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOptionButton(
              icon: Icons.group,
              text: isEnglish ? 'Admins' : 'المشرفين',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalledStudentsListScreen(isEnglish: isEnglish),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            _buildOptionButton(
              icon: Icons.group,
              text: isEnglish ? 'Users' : 'المستخدمين',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersHomeScreen(isEnglish: isEnglish),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({required IconData icon, required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }
}
