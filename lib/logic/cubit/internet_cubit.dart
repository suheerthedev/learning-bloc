import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:learning_bloc/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorConnectivityState();
  }

  void monitorConnectivityState() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((
      connectivityResult,
    ) {
      if (connectivityResult.isNotEmpty) {
        if (connectivityResult.first == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.wifi);
        } else if (connectivityResult.first == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.mobileData);
        } else if (connectivityResult.first == ConnectivityResult.none) {
          emitInternetDisconnected();
        }
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
