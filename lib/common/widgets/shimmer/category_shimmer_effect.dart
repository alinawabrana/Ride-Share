import 'package:flutter/cupertino.dart';
import 'package:ride_share/common/widgets/shimmer/shimmer_effect.dart';

import '../../../utils/constants/sizes.dart';

class TCategoryShimmerEffect extends StatelessWidget {
  const TCategoryShimmerEffect({super.key, this.count = 6});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: count,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect on Image
              AShimmerEffect(width: 55, height: 55, radius: 55),

              SizedBox(height: ASizes.spaceBtwItems / 2),

              // Shimmer effect on Text
              AShimmerEffect(width: 55, height: 0),
            ],
          );
        },
      ),
    );
    ;
  }
}
