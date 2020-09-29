import 'package:flutter/material.dart';
import 'package:persistent_bottomnavigationbar/screens/login/login_screen.dart';
import 'package:persistent_bottomnavigationbar/screens/main/index.dart';
import 'package:persistent_bottomnavigationbar/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.id: (context) => SplashScreen(),
  LoginScreen.id: (context) => LoginScreen(),
  Index.id: (context) => Index(),
};
