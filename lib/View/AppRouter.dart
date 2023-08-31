import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/ChatList.dart';
import 'package:whatsapp_clone/View/add_phone_number.dart';
import 'package:whatsapp_clone/View/onLongPress.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => AddPhoneNumber(),
        );
      case "/second":
        return MaterialPageRoute(
          builder: (context) => ChatList(),
        );
      case "/longPress":
        return MaterialPageRoute(
          builder: (context) => OnLongPress(),
        );
      default:
        return null;
    }
  }
}
