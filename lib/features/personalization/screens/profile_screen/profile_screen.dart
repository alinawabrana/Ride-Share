import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/common/widgets/images/a_circular_image.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/authentication/models/user_model.dart';
import 'package:ride_share/utils/constants/colors.dart';
import 'package:ride_share/utils/constants/image_strings.dart';
import 'package:ride_share/utils/constants/sizes.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';
import 'package:ride_share/utils/loaders/full_screen_loader.dart';
import 'package:ride_share/utils/loaders/loaders.dart';

import '../../../../common/widgets/text_form_field/primary_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneController.text = '0';
    // Delay the call to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AuthCubit>().state;

      if (state is AuthSuccess) {
        nameController.text = state.currentUser.name;
        emailController.text = state.currentUser.email;
        phoneController.text = state.currentUser.phone.toString();
        passwordController.text = state.currentUser.password;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: Colors.white),
        ),
        backgroundColor: AColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: AColors.primaryColor,
                  child: SizedBox(
                    width: AHelperFunctions.screenWidth(context) * 0.9,
                    height: AHelperFunctions.screenHeight(context) * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(ASizes.defaultSpace),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ACircularImage(
                                image:
                                    'assets/images/profile/user-profile-icon-anonymous-person-symbol-Photoroom.png',
                                width: 100,
                                height: 100,
                                padding: 0,
                              ),
                              Positioned(
                                bottom: 5,
                                right: -10,
                                child: IconButton(
                                  onPressed: () {},
                                  color: Colors.blue,
                                  icon: Icon(Iconsax.edit_2, size: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: ASizes.spaceBtwSections),

                          Form(
                            key: updateProfileKey,
                            child: Column(
                              children: [
                                PrimaryTextFormField(
                                  label: 'Name',
                                  controller: nameController,
                                ),
                                SizedBox(height: ASizes.spaceBtwItems),
                                PrimaryTextFormField(
                                  label: 'Phone Number',
                                  controller: phoneController,
                                ),
                                SizedBox(height: ASizes.spaceBtwItems),
                                PrimaryTextFormField(
                                  label: 'Email',
                                  controller: emailController,
                                  enabled: false,
                                  fontColor: Colors.white70,
                                ),
                              ],
                            ),
                          ),

                          Spacer(),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthUpdateLoading) {
                                TFullScreenLoader.openLoadingDialog(
                                  context,
                                  'Updating Data...',
                                  AImages.docerAnimation,
                                );
                              } else if (state
                                  is AuthUpdateFailedWithNoInternet) {
                                TFullScreenLoader.stopLoading(context);
                                ALoaders.warningSnackBar(
                                  context,
                                  state.connectivityMessage,
                                );
                              } else if (state is AuthUpdateSuccess) {
                                TFullScreenLoader.stopLoading(context);
                                ALoaders.successSnackBar(
                                  context,
                                  'Profile Updated Successfully',
                                );
                                Navigator.pop(context);
                              }
                            },
                            builder: (context, state) {
                              final updatedUser = UserModel(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              return SizedBox(
                                width: AHelperFunctions.screenWidth(context),
                                child: ElevatedButton(
                                  onPressed:
                                      () =>
                                          context.read<AuthCubit>().updateUser(
                                            updatedUser,
                                            updateProfileKey,
                                          ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AColors.secondaryColor,
                                  ),
                                  child: Text('Save'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ASizes.spaceBtwSections * 2),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      TFullScreenLoader.openLoadingDialog(
                        context,
                        'Logging Out...',
                        AImages.docerAnimation,
                      );
                    } else if (state is AuthLogoutFailedWithNoInternet) {
                      TFullScreenLoader.stopLoading(context);
                      ALoaders.warningSnackBar(
                        context,
                        state.connectivityMessage,
                      );
                    } else if (state is AuthLogoutSuccess) {
                      TFullScreenLoader.stopLoading(context);
                      ALoaders.successSnackBar(
                        context,
                        'successfully Logged Out',
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (router) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: AHelperFunctions.screenWidth(context),
                      child: ElevatedButton(
                        onPressed: () => context.read<AuthCubit>().logout(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text('Logout'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
