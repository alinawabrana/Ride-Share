// lib/routes/app_routes.dart

import 'package:flutter/material.dart';
import 'package:ride_share/features/authentication/screens/login/login_screen.dart';
import 'package:ride_share/features/authentication/screens/signup/signup_screen.dart';
import 'package:ride_share/features/personalization/screens/profile_screen/profile_screen.dart';
import 'package:ride_share/features/ride_share/screens/select_address_screen/select_address_screen.dart';

import '../../features/ride_share/screens/home/home_screen.dart';
import '../../not_found_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String selectAddress = '/home/selectAddress';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case selectAddress:
        return MaterialPageRoute(builder: (_) => SelectAddressScreen());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundScreen());
    }
  }
}
