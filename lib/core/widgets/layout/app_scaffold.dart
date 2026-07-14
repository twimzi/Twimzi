import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.centerTitle = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  final Widget body;
  final String? title;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool safeArea;
  final bool resizeToAvoidBottomInset;
  final bool centerTitle;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    Widget page = Padding(
      padding: padding,
      child: body,
    );

    if (safeArea) {
      page = SafeArea(child: page);
    }

    return Scaffold(
      backgroundColor:
      backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar ??
          (title != null
              ? AppBar(
            title: Text(title!),
            centerTitle: centerTitle,
          )
              : null),
      body: page,
    );
  }
}