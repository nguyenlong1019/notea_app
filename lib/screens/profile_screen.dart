import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_state.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context, listen: false);

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: const Color(0xFF0F80FF),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 30,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                appState.username ?? 'Unknow Username',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                appState.phone ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                appState.email ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32,),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(CupertinoIcons.lock_circle, color: Color(0xFF87A2FF),),
                title: Text('Privacy Policy', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),),
                trailing: Icon(CupertinoIcons.chevron_forward, color: Color(0xFF87A2FF),),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.help_outline, color: Color(0xFF87A2FF),),
                title: Text('Help Center', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),),
                trailing: Icon(CupertinoIcons.chevron_forward, color: Color(0xFF87A2FF),),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(CupertinoIcons.delete, color: Color(0xFF87A2FF),),
                title: Text('Delete Account', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),),
                trailing: Icon(CupertinoIcons.chevron_forward, color: Color(0xFF87A2FF),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: GestureDetector(
              onTap: () {
                appState.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()));
              },
              child: const Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(CupertinoIcons.arrow_clockwise_circle, color: Color(0xFF87A2FF),),
                  title: Text('Logout', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),),
                  trailing: Icon(CupertinoIcons.chevron_forward, color: Color(0xFF87A2FF),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}