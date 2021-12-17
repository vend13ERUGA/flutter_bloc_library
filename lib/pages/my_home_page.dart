import 'package:flutter/material.dart';
import 'package:flutter_bloc_library/cubit/basket_cubit.dart';
import 'package:flutter_bloc_library/cubit/clock_cubit.dart';
import 'package:flutter_bloc_library/pages/clock_list.dart';
import 'package:flutter_bloc_library/pages/basket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_library/cubit/bottom_nav_cubit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (_) => ClockCubit(),
        ),
        BlocProvider(
          create: (_) => BasketCubit(),
        ),
      ],
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageNavigation = [
    ClockList(),
    Basket(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _pageNavigation[state],
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: Color(0xffFE8A71),
      fixedColor: Color(0xff0E9AA7),
      unselectedItemColor: Color(0xffF6CD61),
      currentIndex: context.read<BottomNavCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Все товары"),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket), label: "Корзина"),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavCubit>().updateIndex(index);
  }
}
