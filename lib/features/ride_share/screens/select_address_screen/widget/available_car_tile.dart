import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class AvailableCarTile extends StatelessWidget {
  const AvailableCarTile({
    super.key,
    required this.carImageUrl,
    required this.title,
    required this.company,
    this.seats = 4,
    this.price = 25.0,
  });

  final String carImageUrl;
  final String title, company;
  final int seats;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image(image: AssetImage(carImageUrl)),
        ),
        SizedBox(width: ASizes.spaceBtwItems / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 3),
            Text(
              company,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(fontSizeFactor: 0.8),
            ),
            SizedBox(height: 3),
            Text(
              '$seats seater',
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.apply(fontSizeFactor: 0.8),
            ),
          ],
        ),
        Spacer(),
        Text(
          '\$$price',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: AColors.primaryColor),
        ),
      ],
    );
  }
}
