import 'package:flutter/cupertino.dart';
import 'package:ride_share/data/services/shared_preferences_service.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/authentication/models/user_model.dart';
import 'package:ride_share/utils/local_storage/storage_utility.dart';

class AuthenticationRepository {
  AuthCubit authCubit;

  AuthenticationRepository({required this.authCubit});
  bool? isLoggedIn = false;

  Future<void> initializeUsers() async {
    isLoggedIn = TLocalStorage.instance().readData('isLoggedIn');
    print('is logged in = $isLoggedIn');

    if (isLoggedIn == true) {
      final currentUser = TLocalStorage.instance().readData('currentUser');
      print(
        'Current User = ${UserModel.fromJson(Map<String, dynamic>.from(currentUser))}',
      );
      authCubit.updateCurrentUser(
        UserModel.fromJson(Map<String, dynamic>.from(currentUser)),
      );
    }
  }
}
