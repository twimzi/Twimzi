import 'package:flutter/material.dart';

class TwimziSearchBar extends StatefulWidget {
  const TwimziSearchBar({
    super.key,
    required this.onChanged,
    this.hintText = 'Search businesses, products, services...',
    this.autofocus = false,
    this.controller,
    this.enabled = true,
  });

  final ValueChanged<String> onChanged;
  final String hintText;
  final bool autofocus;
  final TextEditingController? controller;
  final bool enabled;

  @override
  State<TwimziSearchBar> createState() => _TwimziSearchBarState();
}

class _TwimziSearchBarState extends State<TwimziSearchBar> {
  late final TextEditingController _controller;

  bool get _hasText => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(
          Icons.search_rounded,
        ),
        suffixIcon: _hasText
            ? IconButton(
          tooltip: 'Clear',
          icon: const Icon(
            Icons.close_rounded,
          ),
          onPressed: _clearSearch,
        )
            : null,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}