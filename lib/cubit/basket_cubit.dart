import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/models/basket_data.dart';

class BasketCubit extends Cubit<BasketData> {
  BasketCubit() : super(BasketData([], 0));

  void fetchBasket(BasketListData basket) {
    bool presence = state.basketListData
        .any((element) => element.clockData.id == basket.clockData.id);
    if (!presence) {
      List<BasketListData> newBasket = [basket];
      emit(BasketData(state.basketListData + newBasket, 0));
    } else {
      List<BasketListData> newBasket = [];
      for (var n in state.basketListData) {
        if (n.clockData.id != basket.clockData.id) {
          newBasket.add(n);
        }
      }
      emit(BasketData(newBasket, 0));
    }
  }

  void clearBasket() {
    emit(BasketData([], 0));
  }

  void getFinalPrise() {
    int finalPrice = 0;
    for (var n in state.basketListData) {
      finalPrice += int.parse(n.clockData.price);
    }
    state.finalPrice = finalPrice;
    emit(state);
  }
}
