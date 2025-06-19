import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/common/widgets/icons/a_circular_icon.dart';
import 'package:ride_share/common/widgets/images/a_circular_image.dart';
import 'package:ride_share/common/widgets/list_tiles/menu_tile.dart';
import 'package:ride_share/common/widgets/search/search_bar.dart';
import 'package:ride_share/common/widgets/search/search_container.dart';
import 'package:ride_share/common/widgets/shimmer/shimmer_effect.dart';
import 'package:ride_share/data/routes/app_route.dart';
import 'package:ride_share/data/services/location_service/current_location_data.dart';
import 'package:ride_share/data/services/network_manager/internet_cubit.dart';
import 'package:ride_share/features/authentication/cubit/auth/auth_cubit.dart';
import 'package:ride_share/features/ride_share/cubit/location/location_cubit.dart';
import 'package:ride_share/features/ride_share/screens/home/widget/options_card.dart';
import 'package:ride_share/utils/constants/colors.dart';
import 'package:ride_share/utils/constants/image_strings.dart';
import 'package:ride_share/utils/constants/sizes.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';

import '../../../../common/widgets/list_tiles/row_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SearchController searchController = SearchController();

  @override
  void initState() {
    super.initState();
    context.read<LocationCubit>().fetchLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ASizes.defaultSpace / 2,
                  vertical: ASizes.defaultSpace,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ACircularImage(
                          image:
                              'assets/images/profile/user-profile-icon-anonymous-person-symbol-Photoroom.png',
                          padding: 0,
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                AppRoutes.profile,
                              ),
                        ),
                        Column(
                          children: [
                            Text(
                              'Your Location',
                              style: Theme.of(context).textTheme.labelMedium!
                                  .apply(color: Colors.white70),
                            ),
                            SizedBox(height: ASizes.spaceBtwItems / 2),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap:
                                      () =>
                                          context
                                              .read<LocationCubit>()
                                              .fetchLocation(),
                                  child: Icon(
                                    Iconsax.location,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: ASizes.spaceBtwItems / 2.5),
                                BlocBuilder<LocationCubit, LocationState>(
                                  builder: (context, state) {
                                    if (state is LocationLoading) {
                                      return const Center(
                                        child: AShimmerEffect(
                                          width: 100,
                                          height: 25,
                                        ),
                                      );
                                    } else if (state is LocationSuccess) {
                                      return Text(
                                        state.address,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      );
                                    } else if (state is LocationError) {
                                      return Center(
                                        child: SizedBox(
                                          width: 200,
                                          child: Text(
                                            'Error: ${state.message}',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        ACircularIcon(
                          icon: Iconsax.notification,
                          backgroundColor: AColors.accent,
                          color: Colors.white,
                          size: ASizes.md * 1.2,
                          haveRedDot: true,
                        ),
                      ],
                    ),
                    SizedBox(height: ASizes.spaceBtwSections),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RidPay Balance',
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.apply(color: Colors.white70),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '\$ 263.90',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.apply(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: ASizes.spaceBtwSections),
                    ASearchContainer(
                      text: 'Where to?',
                      textColor: Colors.white,
                      backgroundColor: AColors.accent,
                      showBorder: false,
                      icon: Icon(Iconsax.location, color: AColors.white),
                      iconColor: Colors.white,
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            AppRoutes.selectAddress,
                          ),
                    ),
                    SizedBox(height: ASizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RowTile(
                          icon: Iconsax.home,
                          title: 'Home',
                          subTitle: 'Add address',
                        ),
                        RowTile(
                          icon: Iconsax.building,
                          title: 'Work',
                          subTitle: 'Add address',
                        ),
                        RowTile(
                          icon: Iconsax.buildings_2,
                          title: 'Others',
                          subTitle: 'Add address',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ASizes.spaceBtwSections),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ASizes.defaultSpace / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More option for you',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  SizedBox(
                    height: 130,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // number of rows
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1, // width / height
                          ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return OptionsCard(
                          image: AImages.optionImage_1,
                          text: 'Delivery',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ASizes.spaceBtwItems),
            Container(
              width: AHelperFunctions.screenWidth(context),
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AImages.backgroundCarImage),
                  fit: BoxFit.none,
                  alignment: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(ASizes.defaultSpace / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Want to Rent?',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rent a car for whole day',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: ASizes.spaceBtwItems),
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text('Rent a car'),
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
