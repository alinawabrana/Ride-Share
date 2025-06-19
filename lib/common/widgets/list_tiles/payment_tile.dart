import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../container/rounded_container.dart';

class APaymentTile extends StatelessWidget {
  const APaymentTile({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {},
      leading: ARoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: darkMode ? AColors.light : AColors.white,
        padding: const EdgeInsets.all(ASizes.sm),
        child: Image(
          image: AssetImage('assets/images/payment/images-2.jpeg'),
          fit: BoxFit.contain,
        ),
      ),
      title: Text('RidPay Balance'),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
