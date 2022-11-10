import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModel = readHomeViewModel(ref);
    // final state = useHomeState(ref);

    return ScaffoldWidget(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Text('Pokemon list'),
          ],
        ),
      ),
    );
  }
}
