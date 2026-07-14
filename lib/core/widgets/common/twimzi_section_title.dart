import 'package:flutter/material.dart';

class TwimziSectionTitle extends StatelessWidget {
  final String title;

  const TwimziSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}