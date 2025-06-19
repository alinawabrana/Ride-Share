import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ride_share/utils/helpers/helper_function.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ASearchContainer extends StatelessWidget {
  const ASearchContainer({
    super.key,
    required this.text,
    this.icon = const Icon(Iconsax.location, color: AColors.darkerGrey),
    this.showBackground = true,
    this.showBorder = true,
    this.hasSubtitle = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
    this.backgroundColor,
    this.borderRadius = 32.0,
    this.textSizeFactor = 1,
    this.textColor,
    this.iconColor,
    this.spaceBetweenIconText = 5,
    this.subTitle,
  });

  final String text;
  final String? subTitle;
  final bool showBackground, showBorder, hasSubtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderRadius, textSizeFactor;
  final double? spaceBetweenIconText;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: AHelperFunctions.screenWidth(context),
          padding: const EdgeInsets.all(ASizes.md),
          decoration: BoxDecoration(
            // If show Background = true then how background else show transparent
            color:
                showBackground
                    ? backgroundColor
                    : darkMode
                    ? AColors.dark
                    : Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: showBorder ? Border.all(color: AColors.grey) : null,
          ),
          child: Row(
            children: [
              icon,
              SizedBox(width: spaceBetweenIconText),
              hasSubtitle
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subTitle ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(height: 2),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: textColor,
                          fontSizeFactor: textSizeFactor,
                        ),
                      ),
                    ],
                  )
                  : Text(
                    text,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.apply(color: textColor),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
