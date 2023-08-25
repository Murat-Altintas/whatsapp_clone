import 'package:flutter/material.dart';
import 'package:whatsapp_clone/View/ChatList.dart';
import 'package:whatsapp_clone/View/add_phone_number.dart';

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
      default:
        return null;
    }
  }
}