import 'package:flutter/material.dart';
import 'package:ride_share/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            AShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: ASizes.spaceBtwItems),
            Column(
              children: [
                AShimmerEffect(width: 100, height: 15),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                AShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
