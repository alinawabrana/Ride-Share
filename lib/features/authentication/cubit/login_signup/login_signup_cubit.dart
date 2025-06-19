import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_signup_state.dart';

class LoginSignupCubit extends Cubit<LoginSignupState> {
  bool showPassword = false;
  bool showSignupPassword = false;
  bool showConfirmPassword = false;

  LoginSignupCubit() : super(LoginSignupInitial(false, false, false));

  void toggleLoginPassword() {
    showPassword = !showPassword;
    emit(LoginSignupUpdateLoginShow(showPassword));
  }

  void toggleSignupPassword() {
    showSignupPassword = !showSignupPassword;
    emit(LoginSignupUpdateSignShow(showSignupPassword));
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    emit(LoginSignupUpdateSignConfirmShow(showConfirmPassword));
  }
}
