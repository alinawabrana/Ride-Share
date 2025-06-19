import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetStatus> {
  InternetCubit() : super(InternetStatus(ConnectivityStatus.disconnected));

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      emit(InternetStatus(ConnectivityStatus.disconnected));
    } else {
      emit(InternetStatus(ConnectivityStatus.connected));
    }
  }

  // For continous tracking of Connection.

  late StreamSubscription<ConnectivityResult?> subscription;

  void trackConnectivityChange() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityStatus(result);
    });

    @override
    Future<void> close() {
      subscription.cancel();
      return super.close();
    }
  }
}
