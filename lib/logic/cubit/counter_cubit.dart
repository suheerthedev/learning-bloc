import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_bloc/constants/enums.dart';
import 'package:learning_bloc/logic/cubit/internet_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
    : super(CounterState(counterValue: 0)) {
    monitorInternetState();
  }

  void monitorInternetState() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.mobileData) {
        decrement();
      }
    });
  }

  void increment() => emit(
    CounterState(counterValue: state.counterValue + 1, wasIncremented: true),
  );

  void decrement() => emit(
    CounterState(counterValue: state.counterValue - 1, wasIncremented: false),
  );

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
