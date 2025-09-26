import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/logic/cubit/counter_cubit.dart';
import 'package:learning_bloc/presentation/screens/home_screen.dart';
import 'package:learning_bloc/presentation/screens/second_screen.dart';
import 'package:learning_bloc/presentation/screens/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CounterCubit _counterCubit = CounterCubit();

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Bloc App',
      theme: ThemeData(
        primaryColor: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => BlocProvider.value(
          value: _counterCubit,
          child: HomeScreen(title: 'Home Screen', color: Colors.blueAccent),
        ),
        '/second': (context) => BlocProvider.value(
          value: _counterCubit,
          child: SecondScreen(title: 'Second Screen', color: Colors.redAccent),
        ),
        '/third': (context) => BlocProvider.value(
          value: _counterCubit,
          child: ThirdScreen(title: 'Third Screen', color: Colors.greenAccent),
        ),
      },
    );
  }
}
