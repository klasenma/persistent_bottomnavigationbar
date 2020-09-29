import 'package:flutter/material.dart';
import 'package:persistent_bottomnavigationbar/screens/main/index.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _init() async {
    await sleep();
    // normally this would be the place to check if a user is logged in or not.
    // For this minimal example we assume that he is logged in and navigate him to the main screen with the BottomNavigationBar
    Navigator.pushNamedAndRemoveUntil(context, Index.id, (route) => false);
  }

  Future sleep() {
    return new Future.delayed(const Duration(seconds: 2), () => "2");
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
