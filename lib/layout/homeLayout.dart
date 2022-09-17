import 'package:ecommerce/shared/cubit/shopCubit.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homeLayout extends StatelessWidget {
  const homeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ShopCubit.get(context)
              .screens[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: ShopCubit.get(context).currentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.blueGrey,
            selectedLabelStyle: TextStyle(fontFamily: 'jannah'),
            unselectedLabelStyle:
                TextStyle(fontFamily: 'jannah', color: Colors.grey),
            onTap: (index) {
              ShopCubit.get(context).ChangeNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
