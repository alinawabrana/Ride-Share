import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/data/routes/app_route.dart';
import 'package:ride_share/data/services/network_manager/internet_cubit.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/authentication/cubit/login_signup/login_signup_cubit.dart';
import 'package:ride_share/utils/constants/colors.dart';
import 'package:ride_share/utils/constants/image_strings.dart';
import 'package:ride_share/utils/constants/sizes.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';
import 'package:ride_share/utils/loaders/full_screen_loader.dart';
import 'package:ride_share/utils/loaders/loaders.dart';
import 'package:ride_share/utils/validators/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late InternetCubit internetCubit;
  late AuthCubit authCubit;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    internetCubit = context.read<InternetCubit>();
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    authCubit.disposeLogin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                isDark ? AImages.darkAppLogo : AImages.lightAppLogo,
                width: 150,
                height: 150,
              ),
              SizedBox(height: ASizes.spaceBtwSections * 3),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    TFullScreenLoader.openLoadingDialog(
                      context,
                      'Checking Credentials...',
                      AImages.docerAnimation,
                    );
                  }
                  if (state is AuthSuccess) {
                    TFullScreenLoader.stopLoading(context);
                    ALoaders.successSnackBar(context, 'Successfully Logged In');
                    Navigator.pushNamed(context, AppRoutes.home);
                  } else if (state is AuthFailed) {
                    TFullScreenLoader.stopLoading(context);
                    ALoaders.errorSnackBar(context, state.message);
                  } else if (state is AuthFailedWithNoInternet) {
                    TFullScreenLoader.stopLoading(context);
                    ALoaders.warningSnackBar(
                      context,
                      state.connectivityMessage,
                    );
                  }
                },
                builder: (context, state) {
                  final authCubit = context.read<AuthCubit>();
                  return Card(
                    color: isDark ? AColors.dark : AColors.light,
                    child: Padding(
                      padding: const EdgeInsets.all(ASizes.defaultSpace),
                      child: Column(
                        children: [
                          Form(
                            key: loginFormKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: authCubit.loginEmailController,
                                  decoration: InputDecoration(
                                    label: Text('Email'),
                                  ),
                                  onTapOutside:
                                      (value) =>
                                          FocusScope.of(context).unfocus(),
                                  validator:
                                      (value) =>
                                          AValidator.validateEmail(value),
                                ),
                                SizedBox(height: ASizes.spaceBtwItems),
                                BlocBuilder<LoginSignupCubit, LoginSignupState>(
                                  builder: (context, state) {
                                    final showPassword =
                                        context
                                            .read<LoginSignupCubit>()
                                            .showPassword;
                                    return TextFormField(
                                      controller:
                                          authCubit.loginPasswordController,
                                      obscureText: !showPassword,
                                      decoration: InputDecoration(
                                        label: Text('Password'),
                                        suffixIcon: IconButton(
                                          onPressed:
                                              () =>
                                                  context
                                                      .read<LoginSignupCubit>()
                                                      .toggleLoginPassword(),
                                          icon: Icon(
                                            showPassword
                                                ? Iconsax.eye
                                                : Iconsax.eye_slash,
                                          ),
                                        ),
                                      ),
                                      onTapOutside:
                                          (value) =>
                                              FocusScope.of(context).unfocus(),
                                      validator:
                                          (value) =>
                                              AValidator.validatePassword(
                                                value,
                                              ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ASizes.spaceBtwItems),
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              Text(
                                'Remember Me',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                          SizedBox(height: ASizes.spaceBtwSections),
                          SizedBox(
                            width: AHelperFunctions.screenWidth(context),
                            child: ElevatedButton(
                              onPressed: () => authCubit.login(loginFormKey),
                              child: Text('Login'),
                            ),
                          ),
                          SizedBox(height: ASizes.spaceBtwItems),
                          SizedBox(
                            width: AHelperFunctions.screenWidth(context),
                            child: OutlinedButton(
                              onPressed:
                                  () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.signup,
                                  ),
                              child: Text('Sign Up'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
