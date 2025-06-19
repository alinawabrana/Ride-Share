import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';

class RowTile extends StatelessWidget {
  const RowTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
  });

  final IconData icon;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: ASizes.spaceBtwItems / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: Colors.white),
            ),
            Text(
              subTitle ?? '',
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.apply(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }
}
