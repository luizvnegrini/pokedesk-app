//vm's
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation.dart';

//vm's
IHomeViewModel readHomeViewModel(WidgetRef ref) =>
    ref.read(homeViewModel.notifier);

//states
IHomeState useHomeState(WidgetRef ref) => ref.watch(homeViewModel);
