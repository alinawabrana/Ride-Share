import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/data/routes/app_route.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/authentication/cubit/login_signup/login_signup_cubit.dart';
import 'package:ride_share/utils/constants/image_strings.dart';
import 'package:ride_share/utils/constants/sizes.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';
import 'package:ride_share/utils/loaders/full_screen_loader.dart';
import 'package:ride_share/utils/loaders/loaders.dart';
import 'package:ride_share/utils/validators/validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late AuthCubit authCubit;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  void dispose() {
    authCubit.disposeSignup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          children: [
            Text(
              'Let\' create your Account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: ASizes.spaceBtwSections * 2),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(ASizes.defaultSpace),
                child: Column(
                  children: [
                    Form(
                      key: signupFormKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: authCubit.firstNameController,
                                  decoration: InputDecoration(
                                    label: Text('First Name'),
                                  ),
                                  onTapOutside:
                                      (value) =>
                                          FocusScope.of(context).unfocus(),
                                  validator:
                                      (value) => AValidator.validateEmptyText(
                                        'First Name',
                                        value,
                                      ),
                                ),
                              ),
                              SizedBox(width: ASizes.spaceBtwItems),
                              Flexible(
                                child: TextFormField(
                                  controller: authCubit.lastNameController,
                                  decoration: InputDecoration(
                                    label: Text('Last Name'),
                                  ),
                                  onTapOutside:
                                      (value) =>
                                          FocusScope.of(context).unfocus(),
                                  validator:
                                      (value) => AValidator.validateEmptyText(
                                        'Last Name',
                                        value,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ASizes.spaceBtwItems),
                          TextFormField(
                            controller: authCubit.signupEmailController,
                            decoration: InputDecoration(label: Text('Email')),
                            onTapOutside:
                                (value) => FocusScope.of(context).unfocus(),
                            validator:
                                (value) => AValidator.validateEmail(value),
                          ),
                          SizedBox(height: ASizes.spaceBtwItems),
                          TextFormField(
                            controller: authCubit.phoneController,
                            decoration: InputDecoration(
                              label: Text('Phone Number'),
                            ),
                            onTapOutside:
                                (value) => FocusScope.of(context).unfocus(),
                            validator:
                                (value) =>
                                    AValidator.validatePhoneNumber(value),
                          ),
                          SizedBox(height: ASizes.spaceBtwItems),
                          BlocBuilder<LoginSignupCubit, LoginSignupState>(
                            builder: (context, state) {
                              final showPassword =
                                  context
                                      .read<LoginSignupCubit>()
                                      .showSignupPassword;
                              final showConfirmPassword =
                                  context
                                      .read<LoginSignupCubit>()
                                      .showConfirmPassword;
                              return Column(
                                children: [
                                  TextFormField(
                                    controller:
                                        authCubit.signupPasswordController,
                                    obscureText: !showPassword,
                                    decoration: InputDecoration(
                                      label: Text('Password'),
                                      suffixIcon: IconButton(
                                        onPressed:
                                            () =>
                                                context
                                                    .read<LoginSignupCubit>()
                                                    .toggleSignupPassword(),
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
                                            AValidator.validatePassword(value),
                                  ),
                                  SizedBox(height: ASizes.spaceBtwItems),
                                  TextFormField(
                                    controller:
                                        authCubit.confirmPasswordController,
                                    obscureText: !showConfirmPassword,
                                    decoration: InputDecoration(
                                      label: Text('Confirm Password'),
                                      suffixIcon: IconButton(
                                        onPressed:
                                            () =>
                                                context
                                                    .read<LoginSignupCubit>()
                                                    .toggleConfirmPassword(),
                                        icon: Icon(
                                          showConfirmPassword
                                              ? Iconsax.eye
                                              : Iconsax.eye_slash,
                                        ),
                                      ),
                                    ),
                                    onTapOutside:
                                        (value) =>
                                            FocusScope.of(context).unfocus(),
                                    validator: (value) {
                                      if (value !=
                                          authCubit
                                              .signupPasswordController
                                              .text) {
                                        return 'Password and Confirm Password are not same';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: ASizes.spaceBtwSections),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthLoading) {
                                TFullScreenLoader.openLoadingDialog(
                                  context,
                                  'Creating your Account...',
                                  AImages.docerAnimation,
                                );
                              } else if (state is AuthSuccess) {
                                TFullScreenLoader.stopLoading(context);
                                ALoaders.successSnackBar(
                                  context,
                                  'Successfully Logged In',
                                );
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.home,
                                  (router) => false,
                                );
                              } else if (state is AuthFailed) {
                                TFullScreenLoader.stopLoading(context);
                              } else if (state is AuthFailedWithNoInternet) {
                                TFullScreenLoader.stopLoading(context);
                              }
                            },
                            builder: (context, state) {
                              return SizedBox(
                                width: AHelperFunctions.screenWidth(context),
                                child: ElevatedButton(
                                  onPressed:
                                      () => authCubit.signup(signupFormKey),
                                  child: Text('Create Account'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// },
