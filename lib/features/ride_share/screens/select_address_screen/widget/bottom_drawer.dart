import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/features/ride_share/cubit/location/location_cubit.dart';
import 'package:ride_share/utils/constants/image_strings.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';

import '../../../../../common/widgets/clipper/handle_notch_clipper.dart';
import '../../../../../common/widgets/search/search_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'available_car_tile.dart';
import 'current_destination_location_bar.dart';

class BottomDrawer extends StatelessWidget {
  const BottomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return ClipPath(
          clipper: HandleNotchClipper(),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Handle inside the notch
                Container(
                  width: 50,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    color: AColors.primaryColor,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ASizes.defaultSpace,
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(ASizes.defaultSpace / 3),
                      children: [
                        CurrentAndDestinationLocationBar(),

                        SizedBox(height: ASizes.spaceBtwItems),
                        Text(
                          'Available option',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),
                        SizedBox(
                          height: 250,
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return AvailableCarTile(
                                  carImageUrl: AImages.aqua,
                                  title: 'Medium SUV Car',
                                  company: 'Toyota Aqua',
                                  seats: 5,
                                  price: 30.0,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),

                        Text(
                          'Available option',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),

                        SizedBox(height: ASizes.spaceBtwItems),

                        Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(AImages.paymentIcon),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RidPay Balance',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'You have \$362.90 RidPay balance',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(fontSizeFactor: 0.8),
                                ),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                        SizedBox(height: ASizes.spaceBtwItems),
                        SizedBox(
                          width: AHelperFunctions.screenWidth(context),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Find Car'),
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
      },
    );
  }
}
