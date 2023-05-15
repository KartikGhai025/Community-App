import 'package:flutter/material.dart';
import 'package:tango/screens/home.dart';
import 'package:tango/screens/profile.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIdx = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 30),
            label: ' ',
          ),          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message, size: 30),
          //   label: 'Events',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person, size: 30),
          //   label: 'Profile',
          // ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: pages[pageIdx],
      )),
    );
  }
}

List<Widget> pages = [HomeScreen(),Text('add'), Profile()];
