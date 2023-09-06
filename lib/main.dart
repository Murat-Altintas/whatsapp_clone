import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/Control/post_bloc.dart';
import 'package:whatsapp_clone/View/app_router.dart';
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

  //MULTIBLOCProvider!
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => _postBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/second",
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

class PostBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    "Post Bloc Created: $bloc".log();

    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    "Post Bloc onEvent: $event".log();
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    //"Post Fetched: $transition".log();
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    //"Post Bloc onChange: $change".log();
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    "Post Bloc onClose: $bloc".log();
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    "Post Bloc onError: $error, $stackTrace".log();
    super.onError(bloc, error, stackTrace);
  }
}
