part of 'counter_cubit.dart';

final class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({required this.counterValue, this.wasIncremented = false});
}
