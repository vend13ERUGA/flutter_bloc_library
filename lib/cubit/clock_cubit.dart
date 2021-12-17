import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/models/clock_data.dart';
import 'package:flutter_bloc_library/cubit/clock_state.dart';
import 'package:flutter_bloc_library/services/clock_json_parser.dart';

class ClockCubit extends Cubit<ClockListState> {
  ClockCubit() : super(ClockListLoadingState());

  Future<void> fetchClock() async {
    try {
      emit(ClockListLoadingState());
      List<ClockData> loadedClockList = await loadJSON();
      emit(ClockListLoadedState(loadedClock: loadedClockList));
    } catch (_) {
      emit(ClockListErrorState());
    }
  }

  void changeButton(int index) {
    var newState = [...(state as ClockListLoadedState).loadedClock];
    newState[index].inBasket = !newState[index].inBasket;
    emit(ClockListLoadedState(loadedClock: newState));
  }

  void clearButton() {
    var newState = [...(state as ClockListLoadedState).loadedClock];
    for (var item in (state as ClockListLoadedState).loadedClock) {
      item.inBasket = false;
    }
    emit(ClockListLoadedState(loadedClock: newState));
  }
}
