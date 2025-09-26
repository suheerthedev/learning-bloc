import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/logic/cubit/counter_cubit.dart';
import 'package:learning_bloc/presentation/screens/home_screen.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  dynamic onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(title: 'Home Screen', color: Colors.blueAccent),
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(title: 'Second Screen', color: Colors.redAccent),
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _counterCubit,
            child: HomeScreen(title: 'Third Screen', color: Colors.greenAccent),
          ),
        );

      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
