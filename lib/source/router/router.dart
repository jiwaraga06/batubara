import 'package:batubara/source/pages/Auth/GantiPassword.dart';
import 'package:batubara/source/pages/Auth/login.dart';
import 'package:batubara/source/pages/Auth/splashScreen.dart';
import 'package:batubara/source/pages/Batubara/batubara.dart';
import 'package:batubara/source/pages/bottomNav.dart';
import 'package:batubara/source/pages/history/history.dart';
import 'package:batubara/source/router/string.dart';
import 'package:flutter/material.dart';

class RouterNavigation {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASHSCREEN:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => const Login());
      case CHANGE_PW:
        return MaterialPageRoute(builder: (context) => const ChangePassword());
      case BATUBARA:
        return MaterialPageRoute(builder: (context) => const Batubara());
      case BOTTOM_NAV:
        return MaterialPageRoute(builder: (context) => const BottomNav());
      case HISTORY:
        return MaterialPageRoute(builder: (context) => const History());
      default:
        return null;
    }
  }
}
