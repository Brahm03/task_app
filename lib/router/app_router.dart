import 'package:flutter/material.dart';
import 'package:task_wan_app/screens/phone_login.dart';
import 'package:task_wan_app/screens/sign_in.dart';
import 'package:task_wan_app/screens/verification.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => SizedBox());
      case '/login':
        return MaterialPageRoute(builder: (context) => PhoneLogin()); 
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => SignIn()); 
      case '/verification':
        return MaterialPageRoute(builder: (context) => Verification());       
      default:
    }
  }
}
