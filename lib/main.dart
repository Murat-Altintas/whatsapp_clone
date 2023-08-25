import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Control/post_bloc.dart';
import 'package:whatsapp_clone/View/AppRouter.dart';
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
  final AppRouter _appRouter = AppRouter();
  final PostBloc _postBloc = PostBloc(
    client: HttpClient(),
  )..add(PostFetched());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => _postBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

class PostBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    "Post Fetched: $bloc".log();
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    "Post Bloc Created".log();
    super.onCreate(bloc);
  }
}
