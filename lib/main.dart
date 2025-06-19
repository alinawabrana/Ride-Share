import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_share/data/repositories/authentication/authentication.dart';
import 'package:ride_share/data/routes/app_route.dart';
import 'package:ride_share/data/services/network_manager/internet_cubit.dart';
import 'package:ride_share/data/services/shared_preferences_service.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/authentication/cubit/login_signup/login_signup_cubit.dart';
import 'package:ride_share/features/authentication/screens/login/login_screen.dart';
import 'package:ride_share/features/ride_share/cubit/location/location_cubit.dart';
import 'package:ride_share/features/ride_share/screens/home/home_screen.dart';
import 'package:ride_share/utils/local_storage/storage_utility.dart';
import 'package:ride_share/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesService.init();
  await TLocalStorage.init('myApp');

  final internetCubit = InternetCubit()..trackConnectivityChange();

  final authCubit = AuthCubit(internetCubit);

  final authRepo = AuthenticationRepository(authCubit: authCubit);

  await authRepo.initializeUsers();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => authCubit),
        BlocProvider<InternetCubit>(create: (_) => internetCubit),
        BlocProvider<LoginSignupCubit>(create: (_) => LoginSignupCubit()),
        BlocProvider<LocationCubit>(create: (_) => LocationCubit()),
      ],
      child: MyApp(isLoggedIn: authRepo.isLoggedIn ?? false),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Share',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      onGenerateRoute: AppRoutes.generateRoute,
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
