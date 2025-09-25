import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_bloc/cubit/counter_cubit.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit = CounterCubit();
    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
      'the initial state of the CounterCubit is CounterState(counterValue: 0)',
      () {
        expect(counterCubit.state, CounterState(counterValue: 0));
      },
    );

    blocTest<CounterCubit, CounterState>(
      'this incremenet should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment function is called',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => const <CounterState>[
        CounterState(counterValue: 1, wasIncremented: true),
      ],
    );
    blocTest<CounterCubit, CounterState>(
      'this decrement should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement function is called',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => const <CounterState>[
        CounterState(counterValue: -1, wasIncremented: false),
      ],
    );
  });
}
