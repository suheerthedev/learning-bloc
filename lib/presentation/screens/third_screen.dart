import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_bloc/logic/cubit/counter_cubit.dart';

class ThirdScreen extends StatefulWidget {
  final String title;
  final Color color;
  const ThirdScreen({super.key, required this.title, required this.color});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: widget.color,
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
                  backgroundColor: widget.color,
                  child: Icon(Icons.remove, color: Colors.white),
                ),

                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  backgroundColor: widget.color,
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),

            // SizedBox(height: 24),

            // MaterialButton(
            //   onPressed: () {},
            //   color: widget.color,
            //   child: Text('Go to Fourth Screen'),
            // ),
          ],
        ),
      ),
    );
  }
}
