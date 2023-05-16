import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/cart/cart_bloc.dart';
import 'package:flutter_application_2/bloc/cart/cart_event.dart';
import 'package:flutter_application_2/data/model/cart_item.dart';
import 'package:flutter_application_2/screens/cart_screen.dart';
import 'package:flutter_application_2/screens/category_screen.dart';
import 'package:flutter_application_2/screens/home_page.dart';
import 'package:flutter_application_2/screens/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/auth_bloc.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/home/home_bloc.dart';
import 'constants/colors.dart';
import 'di/di.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartitemAdapter());
  await Hive.openBox<CartItems>('Cardbox');
  await GetItInit();

  runApp(const MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: pageindex,
          children: screensList(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: BottomNavigationBar(
              onTap: (int index) {
                setState(() {
                  pageindex = index;
                });
              },
              elevation: 0,
              backgroundColor: Colors.transparent,
              currentIndex: pageindex,
              selectedItemColor: CustomColor.blue,
              selectedIconTheme: const IconThemeData(shadows: [
                BoxShadow(
                  color: CustomColor.blue,
                  blurRadius: 20,
                  spreadRadius: -7,
                  offset: Offset(0, 13),
                )
              ]),
              selectedLabelStyle: const TextStyle(
                fontSize: 13,
                color: CustomColor.blue,
                fontFamily: 'SM',
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 10,
                color: CustomColor.grey,
                fontFamily: 'SM',
              ),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/images/icon_profile_active.png',
                  ),
                  icon: Image.asset(
                    'assets/images/icon_profile.png',
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/images/icon_basket_active.png',
                  ),
                  icon: Image.asset(
                    'assets/images/icon_basket.png',
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/images/icon_category_active.png',
                  ),
                  icon: Image.asset(
                    'assets/images/icon_category.png',
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    'assets/images/icon_home_active.png',
                  ),
                  icon: Image.asset(
                    'assets/images/icon_home.png',
                  ),
                  label: 'خانه',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> screensList() {
  return <Widget>[
    BlocProvider(
      create: (context) => AuthBloc(),
      child: const WelcomePage(),
    ),
    BlocProvider(
      create: ((context) {
        var bloc = locator.get<CartBloc>();
        bloc.add(CartFechHiveEvent());
        return bloc;
      }),
      child: const CartScreen(),
    ),
    BlocProvider(
      create: (context) => CategoryBloc(),
      child: const CategoryScreen(),
    ),
    BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomePage(),
    ),
  ];
}
