import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var widgetList = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  int index = 0;

  Color selectedItem = Colors.blue;
  Color unselectedItem = Colors.grey;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),       
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: index == 0 ? selectedItem : unselectedItem,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: index == 1 ? selectedItem : unselectedItem,),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AddNote()));
          },
          shape: const CircleBorder(),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
                transform: const GradientRotation(pi / 4),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: widgetList[index],
    );
  }
}