import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/carts/carts_scree.dart';
import 'package:shop_app/modules/shop_app/login/login_screen.dart';
import 'package:shop_app/modules/shop_app/search/search_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit , ShopLayoutStates>(
      listener: (context , state){},
      builder: (context , state){

        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(
                        context,
                        SearchScreen()
                    );
                  },
                  icon: Icon(Icons.search)
              ),
              IconButton(
              onPressed: ()
              {
              navigateTo(
              context,
              CartsScree()
              );
              },
              icon: Icon(Icons.shopping_cart_sharp),
              ),
            ],
          ),
          body: cubit.bottomNavBarScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
             selectedItemColor: Colors.black,
             unselectedItemColor: Colors.grey,
             onTap: (index){
               cubit.changeBottomNavBarScreens(index);
             },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home
                    ),
                  label:  'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.favorite
                    ),
                    label:  'Favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.apps
                    ),
                    label:  'Category'
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        Icons.settings
                    ),
                    label:  'Settings'
                ),
              ]
          ),
        );
      },
    );
  }
}
