import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation.dart';

final homeViewModel =
    StateNotifierProvider.autoDispose<IHomeViewModel, IHomeState>(
  (ref) => HomeViewModel(),
);

abstract class IHomeViewModel extends ViewModel<IHomeState> {
  IHomeViewModel(HomeState state) : super(state);

  void updateBottomNavBarIndex(int index);
}

class HomeViewModel extends IHomeViewModel {
  HomeViewModel() : super(HomeState.initial());

  @override
  void updateBottomNavBarIndex(int index) => state = state.copyWith();
}