import 'package:flutter/material.dart';
import 'package:ride_share/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class TBoxesShimmer extends StatelessWidget {
  const TBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: AShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(child: AShimmerEffect(width: 150, height: 110)),
            SizedBox(width: ASizes.spaceBtwItems),
            Expanded(child: AShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
