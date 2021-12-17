import 'package:flutter/material.dart';
import 'package:flutter_bloc_library/cubit/basket_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/cubit/clock_cubit.dart';
import 'package:flutter_bloc_library/models/basket_data.dart';

class Basket extends StatefulWidget {
  Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    final BasketCubit basketCubit = context.read<BasketCubit>();
    final ClockCubit clockCubit = context.read<ClockCubit>();
    basketCubit.getFinalPrise();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0E9AA7),
        centerTitle: true,
        title: Text("Корзина"),
      ),
      body: BlocBuilder<BasketCubit, BasketData>(builder: (contextBloc, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: state.basketListData.length,
              itemBuilder: (context, index) => Container(
                color: index % 2 == 0 ? Colors.white : Color(0xffF6CD61),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        state.basketListData[index].clockData.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.basketListData[index].clockData.price + " ₽",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Итого: " + state.finalPrice.toString() + " ₽"),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(
                    'Купить все',
                    style: TextStyle(color: Color(0xff0E9AA7)),
                  ),
                  onPressed: () {
                    basketCubit.clearBasket();
                    clockCubit.clearButton();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffF6CD61),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
