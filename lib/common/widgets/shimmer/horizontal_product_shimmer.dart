import 'package:flutter/material.dart';
import 'package:ride_share/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ASizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemBuilder:
            (_, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Image
                AShimmerEffect(width: 120, height: 120),
                SizedBox(width: ASizes.spaceBtwItems),

                /// Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: ASizes.spaceBtwItems / 2),
                    AShimmerEffect(width: 165, height: 14),
                    SizedBox(height: ASizes.spaceBtwItems),
                    AShimmerEffect(width: 20, height: 14),
                    SizedBox(height: ASizes.spaceBtwItems),
                  ],
                ),
              ],
            ),
        separatorBuilder:
            (context, index) => const SizedBox(width: ASizes.spaceBtwItems),
        itemCount: itemCount,
      ),
    );
  }
}
