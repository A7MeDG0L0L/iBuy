import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_states.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/search/search.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'iBuy',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    signOut(context);
                  },
                  child: Text('Signout'),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.navIndex],
            bottomNavigationBar: CurvedNavigationBar(
              items: cubit.icons,
              color: defaultColor,
              backgroundColor: Colors.transparent,
              height: 60,
              index: cubit.navIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
            ),
          );
        });
  }
}
