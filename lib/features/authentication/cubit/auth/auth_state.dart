part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthUpdateLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel currentUser;
  AuthSuccess({required this.currentUser});

  AuthSuccess copyWith({UserModel? currentUser}) {
    return AuthSuccess(currentUser: currentUser ?? this.currentUser);
  }
}

final class AuthFailed extends AuthState {
  final String message;
  AuthFailed({required this.message});
}

final class AuthFailedWithNoInternet extends AuthState {
  final String connectivityMessage;
  AuthFailedWithNoInternet({required this.connectivityMessage});
}

final class AuthLogoutSuccess extends AuthState {}

final class AuthUpdateSuccess extends AuthState {}

final class AuthLogoutFailedWithNoInternet extends AuthState {
  final String connectivityMessage;
  AuthLogoutFailedWithNoInternet({required this.connectivityMessage});
}

final class AuthUpdateFailedWithNoInternet extends AuthState {
  final String connectivityMessage;
  AuthUpdateFailedWithNoInternet({required this.connectivityMessage});
}
