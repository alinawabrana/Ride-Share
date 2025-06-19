import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';

class ACircularIcon extends StatelessWidget {
  /// A custom Circular Icon Widget with a background Color
  ///
  /// Properties are:
  /// Container [width], [height], & [backgroundColor]
  ///
  /// Icon's [size], [color] & [onPressed]

  const ACircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = ASizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
    this.haveRedDot = false,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool haveRedDot;

  @override
  Widget build(BuildContext context) {
    final darkMode = AHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (darkMode
                ? AColors.black.withOpacity(0.9)
                : AColors.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: color, size: size),
          ),

          haveRedDot
              ? Positioned(
                top: 18,
                right: 15,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
