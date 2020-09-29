import 'package:flutter/material.dart';
import 'package:persistent_bottomnavigationbar/screens/login/login_screen.dart';
import '../../../enums.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        actions: [
          PopupMenuButton<MenuTabs>(
            onSelected: (MenuTabs result) async {
              // Navigate back to the LoginScreen (this doesn't work as expected...)
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (Route<dynamic> route) => false);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuTabs>>[
              PopupMenuItem<MenuTabs>(
                value: MenuTabs.logout,
                child: Text('Logout'),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SafeArea(
          child: Center(
            child: Text('Home'),
          ),
        ),
      ),
    );
  }
}
