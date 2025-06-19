import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ARoundedContainer extends StatelessWidget {
  const ARoundedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = ASizes.cardRadiusLg,
    this.child,
    this.showBorder = true,
    this.borderColor = AColors.borderPrimary,
    this.backgroundColor = AColors.white,
  });

  final double? width, height;
  final EdgeInsetsGeometry? padding, margin;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
