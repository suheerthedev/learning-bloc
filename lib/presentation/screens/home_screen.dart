import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/constants/enums.dart';
import 'package:learning_bloc/logic/cubit/counter_cubit.dart';
import 'package:learning_bloc/logic/cubit/internet_cubit.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final Color color;
  const HomeScreen({super.key, required this.title, required this.color});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobileData) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          backgroundColor: widget.color,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnected &&
                        state.connectionType == ConnectionType.wifi) {
                      return Text(
                        'Wifi',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: Colors.green),
                      );
                    } else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.mobileData) {
                      return Text(
                        'Mobile',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: Colors.yellow),
                      );
                    } else if (state is InternetDisconnected) {
                      return Text(
                        'Disconnected',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge?.copyWith(color: Colors.red),
                      );
                    } else if (state is InternetLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Checking Connection',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(color: Colors.orange),
                          ),
                          CircularProgressIndicator(color: Colors.orange),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
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
                        // BlocProvider.of<CounterCubit>(context).decrement();

                        context.read<CounterCubit>().decrement();
                      },
                      tooltip: 'Decrement',
                      backgroundColor: widget.color,
                      child: Icon(Icons.remove, color: Colors.white),
                    ),

                    FloatingActionButton(
                      onPressed: () {
                        // BlocProvider.of<CounterCubit>(context).increment();
                        context.read<CounterCubit>().increment();
                      },
                      tooltip: 'Increment',
                      backgroundColor: widget.color,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second');
                  },
                  color: Colors.redAccent,
                  child: Text(
                    'Go to Second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 24),

                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/third');
                  },
                  color: Colors.greenAccent,
                  child: Text(
                    'Go to Third Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
