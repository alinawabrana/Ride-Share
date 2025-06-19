part of 'login_signup_cubit.dart';

sealed class LoginSignupState {}

final class LoginSignupInitial extends LoginSignupState {
  final bool showPassword;
  final bool showSignupPassword;
  final bool showConfirmPassword;
  LoginSignupInitial(
    this.showPassword,
    this.showSignupPassword,
    this.showConfirmPassword,
  );
}

final class LoginSignupUpdateLoginShow extends LoginSignupState {
  final bool showPassword;
  LoginSignupUpdateLoginShow(this.showPassword);
}

final class LoginSignupUpdateSignShow extends LoginSignupState {
  final bool showPassword;
  LoginSignupUpdateSignShow(this.showPassword);
}

final class LoginSignupUpdateSignConfirmShow extends LoginSignupState {
  final bool showPassword;
  LoginSignupUpdateSignConfirmShow(this.showPassword);
}
