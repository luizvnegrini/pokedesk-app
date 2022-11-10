import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;

  const ScaffoldWidget({
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      );
}
