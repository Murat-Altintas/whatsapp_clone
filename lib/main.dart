import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/View/add_phone_number.dart';
import 'package:whatsapp_clone/utils/extensions.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = PostBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AddPhoneNumber(),
        ));
  }
}

class PostBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    "Bloc: $bloc".log();
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    "Post Bloc Created".log();
    super.onCreate(bloc);
  }
}
