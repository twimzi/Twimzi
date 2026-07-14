import 'package:flutter/material.dart';

class TwimziCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const TwimziCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}