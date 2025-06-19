import 'package:flutter/material.dart';

// ✅ Custom Clipper for notch effect
class HandleNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const notchWidth = 60.0;
    const notchHeight = 10.0;

    final path = Path();
    path.moveTo(0, 20); // start a bit lower to make rounded top
    path.quadraticBezierTo(0, 0, 20, 0);

    // Left of notch
    path.lineTo((size.width - notchWidth) / 2 - 10, 0);
    path.quadraticBezierTo(
      (size.width - notchWidth) / 2,
      0,
      (size.width - notchWidth) / 2,
      notchHeight,
    );

    // Notch
    path.lineTo((size.width + notchWidth) / 2, notchHeight);
    path.quadraticBezierTo(
      (size.width + notchWidth) / 2,
      0,
      (size.width + notchWidth) / 2 + 10,
      0,
    );

    // Right to end
    path.lineTo(size.width - 20, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
