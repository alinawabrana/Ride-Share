import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:ride_share/data/services/network_manager/internet_cubit.dart';
import 'package:ride_share/features/authentication/models/user_model.dart';
import 'package:ride_share/utils/loaders/full_screen_loader.dart';
import 'package:ride_share/utils/local_storage/storage_utility.dart';
import 'package:ride_share/utils/validators/validation.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  bool showPassword = false;
  bool showSignupPassword = false;
  bool showConfirmPassword = false;

  final InternetCubit internetCubit;

  AuthCubit(this.internetCubit) : super(AuthInitialState());

  Future<void> login(GlobalKey<FormState> loginFormKey) async {
    // Validating the input fields
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    emit(AuthLoading());

    // Checking Internet Connection
    internetCubit.trackConnectivityChange();

    ConnectivityStatus internetStatus = internetCubit.state.status;

    if (internetStatus == ConnectivityStatus.disconnected) {
      emit(
        AuthFailedWithNoInternet(connectivityMessage: 'No Internet Connection'),
      );
      return;
    }

    await Future.delayed(Duration(seconds: 2));

    // Checking if user already exists or not. If yes then proceed else Sign Up.
    final data = TLocalStorage.instance().readData('users');

    if (data == null) {
      emit(AuthFailed(message: 'Invalid Email or Password'));
      return;
    }

    final List<UserModel> usersList =
        (data != null)
            ? (data as List)
                .map(
                  (json) => UserModel.fromJson(Map<String, dynamic>.from(json)),
                )
                .toList()
            : [];

    if (usersList.any(
      (user) =>
          user.email == loginEmailController.text.trim() &&
          user.password == loginPasswordController.text.trim(),
    )) {
      final currentUser = usersList.firstWhere(
        (user) =>
            user.email == loginEmailController.text.trim() &&
            user.password == loginPasswordController.text.trim(),
      );
      TLocalStorage.instance().saveData('isLoggedIn', true);
      emit(AuthSuccess(currentUser: currentUser));

      TLocalStorage.instance().saveData('currentUser', currentUser.toJson());
    } else {
      emit(AuthFailed(message: "Invalid email or password"));
    }
  }

  Future<void> signup(GlobalKey<FormState> signupFormKey) async {
    // Validating the input fields
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    emit(AuthLoading());

    final newUser = UserModel(
      name:
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
      email: signupEmailController.text.trim(),
      phone: phoneController.text.trim(),
      password: signupPasswordController.text.trim(),
    );

    // Checking Internet Connection
    internetCubit.trackConnectivityChange();

    ConnectivityStatus internetStatus = internetCubit.state.status;

    if (internetStatus == ConnectivityStatus.disconnected) {
      emit(
        AuthFailedWithNoInternet(connectivityMessage: 'No Internet Connection'),
      );
      return;
    }

    await Future.delayed(Duration(seconds: 2));

    // Fetching previous data of users from GetStorage. Adding the current sign up data to it.
    final data = TLocalStorage.instance().readData('users');

    final List<UserModel> usersList =
        (data != null)
            ? (data as List)
                .map(
                  (json) => UserModel.fromJson(Map<String, dynamic>.from(json)),
                )
                .toList()
            : [];

    if (usersList.any(
      (user) => user.email == signupEmailController.text.trim(),
    )) {
      emit(AuthFailed(message: 'Email Already Registered.'));
      return;
    }

    usersList.add(newUser);

    TLocalStorage.instance().saveData('users', usersList);
    TLocalStorage.instance().saveData('currentUser', newUser);
    TLocalStorage.instance().saveData('isLoggedIn', true);

    emit(AuthSuccess(currentUser: newUser));
  }

  Future<void> logout() async {
    emit(AuthLoading());

    // Checking Internet Connection
    internetCubit.trackConnectivityChange();

    ConnectivityStatus internetStatus = internetCubit.state.status;

    if (internetStatus == ConnectivityStatus.disconnected) {
      emit(
        AuthLogoutFailedWithNoInternet(
          connectivityMessage: 'No Internet Connection',
        ),
      );
      return;
    }

    await Future.delayed(Duration(seconds: 2));

    TLocalStorage.instance().saveData('isLoggedIn', false);
    emit(AuthLogoutSuccess());
  }

  Future<void> updateUser(
    UserModel updatedUser,
    GlobalKey<FormState> updatedKey,
  ) async {
    if (!updatedKey.currentState!.validate()) {
      return;
    }

    emit(AuthUpdateLoading());

    // Checking Internet Connection
    internetCubit.trackConnectivityChange();

    ConnectivityStatus internetStatus = internetCubit.state.status;

    if (internetStatus == ConnectivityStatus.disconnected) {
      emit(
        AuthUpdateFailedWithNoInternet(
          connectivityMessage: 'No Internet Connection',
        ),
      );
      return;
    }

    await Future.delayed(Duration(seconds: 2));

    // Checking if user already exists or not. If yes then proceed else Sign Up.
    final data = TLocalStorage.instance().readData('users');

    final List<UserModel> usersList =
        (data != null)
            ? (data as List)
                .map(
                  (json) => UserModel.fromJson(Map<String, dynamic>.from(json)),
                )
                .toList()
            : [];

    usersList.removeWhere((user) => user.email == updatedUser.email);

    usersList.add(updatedUser);
    emit(AuthUpdateSuccess());
    updateCurrentUser(updatedUser);
  }

  void updateCurrentUser(UserModel currentUser) {
    emit(AuthSuccess(currentUser: currentUser));
  }

  void disposeLogin() {
    loginPasswordController.text = '';
    loginEmailController.text = '';
  }

  void disposeSignup() {
    signupEmailController.text = '';
    signupPasswordController.text = '';
    firstNameController.text = '';
    lastNameController.text = '';
    phoneController.text = '';
    confirmPasswordController.text = '';
  }
}
