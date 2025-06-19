import 'package:flutter/material.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key, required this.image, required this.text});

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Image(width: 80, height: 80, image: AssetImage(image)),
          Text(text, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
