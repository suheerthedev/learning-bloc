import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Counter Bloc App',
        theme: ThemeData(
          primaryColor: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(title: 'Counter App'),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incremented :)'),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Decremented :('),
                      duration: Duration(milliseconds: 200),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'WHOPPS, NEGATIVE VALUE',
                    style: TextStyle(
                      fontSize: 26,

                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                }
                if (state.counterValue % 2 == 0) {
                  return Text(
                    '${state.counterValue} is Even',
                    style: TextStyle(
                      fontSize: 26,

                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Text(
                    '${state.counterValue} is Odd',
                    style: TextStyle(
                      fontSize: 26,

                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();

                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.remove, color: Colors.white),
                ),

                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
