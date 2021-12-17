import 'package:flutter_bloc_library/models/clock_data.dart';

class BasketListData {
  final ClockData clockData;
  int quantity;
  BasketListData(this.clockData, this.quantity);
}

class BasketData {
  List<BasketListData> basketListData;
  int finalPrice;
  BasketData(this.basketListData, this.finalPrice);
}
