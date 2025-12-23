import 'package:flutter/material.dart';
import 'package:task_wan_app/screens/home_screen.dart';
import 'package:task_wan_app/screens/phone_login.dart';
import 'package:task_wan_app/screens/sign_in.dart';
import 'package:task_wan_app/screens/sign_up_screen.dart';
import 'package:task_wan_app/screens/verification.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (context) => SignUpScreen());  
      case '/login':
        return MaterialPageRoute(builder: (context) => PhoneLogin());
      case '/sign_in':
        return MaterialPageRoute(builder: (context) => SignIn());
      case '/verification':
        return MaterialPageRoute(
          builder: (context) => Verification(
            phoneNumber: (settings.arguments as List)[0],
            verificationID: (settings.arguments as List)[1],
          ),
        );
      default:
    }
  }
}
