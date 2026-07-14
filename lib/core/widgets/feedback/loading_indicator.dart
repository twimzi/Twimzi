import 'package:flutter/material.dart';

class TwimziLoadingIndicator extends StatefulWidget {
  const TwimziLoadingIndicator({
    super.key,
    this.size = 12,
    this.color,
    this.spacing = 6,
  });

  final double size;
  final Color? color;
  final double spacing;

  @override
  State<TwimziLoadingIndicator> createState() =>
      _TwimziLoadingIndicatorState();
}

class _TwimziLoadingIndicatorState extends State<TwimziLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = (_controller.value + (index * 0.2)) % 1.0;

        final scale = progress < 0.5
            ? 0.6 + (progress * 0.8)
            : 1.0 - ((progress - 0.5) * 0.8);

        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color ?? Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(0),
        SizedBox(width: widget.spacing),
        _dot(1),
        SizedBox(width: widget.spacing),
        _dot(2),
      ],
    );
  }
}