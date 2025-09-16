import 'package:doctors_app/screens/home/home.dart';
// import 'package:doctors_app/screens/shedule_screen.dart/features/shedule_skeletonizer.dart';
import 'package:doctors_app/screens/shedule_screen.dart/shedule.dart';
import 'package:doctors_app/screens/user/user.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DoctorHomePage(),
    DoctorSchedulePage(),
    User(),
  ];

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("assets/images/card7.png"),)),child: _pages[_selectedIndex]),

      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: _onButtonPressed,
        iconSize: 30,
        activeColor: Colors.blue,
        selectedIndex: _selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.home,
            title: 'Home',
          ),
          BarItem(
            icon: Icons.schedule,
            title: 'Schedule',
          ),
          BarItem(
            icon: Icons.person,
            title: 'User',
          ),
        ],
      ),
    );
  }
}
