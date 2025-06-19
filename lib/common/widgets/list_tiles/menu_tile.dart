import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_function.dart';

class AMenuTile extends StatelessWidget {
  const AMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.subTitleColor,
    this.iconSize = 20,
    this.horizontalPadding,
    this.horizontalTitleGap,
  });

  final IconData icon;
  final String title, subTitle;
  final Color? iconColor, titleColor, subTitleColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double iconSize;
  final double? horizontalPadding, horizontalTitleGap;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 16.0,
      ), // Reduced horizontal padding
      horizontalTitleGap: horizontalTitleGap ?? 16.0,
      leading: Icon(
        icon,
        color: iconColor ?? AColors.primaryColor,
        size: iconSize,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.apply(
          color: titleColor ?? (darkMode ? AColors.white : AColors.black),
          fontWeightDelta: 2,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.apply(color: subTitleColor),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
