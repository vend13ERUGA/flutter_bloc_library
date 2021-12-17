import 'package:flutter/material.dart';
import 'package:flutter_bloc_library/cubit/basket_cubit.dart';
import 'package:flutter_bloc_library/cubit/clock_state.dart';
import 'package:flutter_bloc_library/cubit/clock_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/models/basket_data.dart';

class ClockList extends StatelessWidget {
  const ClockList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClockCubit clockCubit = context.read<ClockCubit>();
    final BasketCubit basketCubit = context.read<BasketCubit>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
          colors: <Color>[Colors.white, Color(0xffF6CD61)],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Color(0xff0E9AA7),
          centerTitle: true,
          title: Text("ROLEX"),
        ),
        body: BlocBuilder<ClockCubit, ClockListState>(
          builder: (context, state) {
            if (state is ClockListLoadingState) {
              clockCubit.fetchClock();
              return Center(child: CircularProgressIndicator());
            }

            if (state is ClockListLoadedState) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: (0.7),
                    crossAxisCount: 2,
                  ),
                  itemCount: state.loadedClock.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            image: NetworkImage(state.loadedClock[index].url),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                          Text(state.loadedClock[index].name),
                          Text(
                              state.loadedClock[index].price.toString() + " ₽"),
                          Center(
                              child: RaisedButton(
                            color: state.loadedClock[index].inBasket
                                ? Color(0xffFE8A71)
                                : Color(0xffA5D1D5),
                            child: Row(
                              children: [
                                Text(state.loadedClock[index].inBasket
                                    ? "В корзине"
                                    : "Добавить в корзину")
                              ],
                            ),
                            onPressed: () {
                              basketCubit.fetchBasket(
                                  BasketListData(state.loadedClock[index], 1));
                              clockCubit.changeButton(index);
                            },
                          )),
                        ],
                      ),
                    );
                  });
            }

            if (state is ClockListErrorState) {
              return Center(
                child: Text(
                  'Error fetching users',
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
