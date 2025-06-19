import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/features/ride_share/cubit/location/location_cubit.dart';

import '../../../../../common/widgets/search/search_container.dart';
import '../../../../../utils/constants/colors.dart';

class CurrentAndDestinationLocationBar extends StatelessWidget {
  const CurrentAndDestinationLocationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Column(
          children: [
            ASearchContainer(
              text:
                  (state is LocationSuccess)
                      ? state.address
                      : 'You Current Location',
              textSizeFactor: 0.9,
              hasSubtitle: true,
              subTitle: 'Start Location',
              backgroundColor: Colors.grey.shade100,
              showBorder: false,
              icon: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // cleaner than borderRadius for circles
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AColors.secondaryColor,
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
            SizedBox(height: 5),
            Text('to', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 5),
            ASearchContainer(
              text: 'Your Destination Location',
              textSizeFactor: 0.9,
              hasSubtitle: true,
              subTitle: 'your Destination',
              backgroundColor: Colors.grey.shade100,
              showBorder: false,
              icon: Icon(Iconsax.location, color: AColors.darkerGrey),
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
