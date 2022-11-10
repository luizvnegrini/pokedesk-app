import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';

class MainRoutes {
  static String get _source => '/home';
  static String get home => _source;
}

List<MapEntry<String, Widget Function(BuildContext)>> mainRoutes = [
  MapEntry(
    '/',
    (context) => const HomePage(),
  ),
];
