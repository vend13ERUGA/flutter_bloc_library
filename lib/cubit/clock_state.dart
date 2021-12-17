import 'package:flutter_bloc_library/models/clock_data.dart';

abstract class ClockListState {}

class ClockListLoadingState extends ClockListState {}

class ClockListLoadedState extends ClockListState {
  List<ClockData> loadedClock;
  ClockListLoadedState({required this.loadedClock})
      : assert(loadedClock.isNotEmpty);
}

class ClockListErrorState extends ClockListState {}
