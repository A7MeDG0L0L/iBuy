import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter/models/shop_app/home_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/categories/categories.dart';
import 'package:udemy_flutter/modules/shop_app/favorites/favorites.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_states.dart';
import 'package:udemy_flutter/modules/shop_app/products/products.dart';
import 'package:udemy_flutter/modules/shop_app/settings/settings.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/end_points.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  var token = CacheHelper.getData(key: 'token');

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> icons = [
    Icon(
      Icons.home,
      color: Colors.white,
    ),
    Icon(
      Icons.apps,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite_border,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
    ),
  ];

  int navIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeNavBar(int index) {
    navIndex = index;
    emit(NavBarIndexChangerState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(HomeLoadingGetDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      //print(DioHelper.dio.options.headers);
      homeModel = HomeModel.fromJson(value.data);

      homeModel.data.products.forEach((element) {
        favorites.addAll(
          {element.id: element.inFavorites},
        );
      });

      //print(homeModel.toString());
      emit(HomeSuccessGetDataState());
    }).catchError((error) {
      print(error);
      emit(HomeErrorGetDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategory() {
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      // print(DioHelper.dio.options.headers);
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategorySuccessGetDataState());
    }).catchError((error) {
      print(error);
      emit(CategoryErrorGetDataState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ChangeFavoritesSuccessState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      // print(DioHelper.dio.options.headers);

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (changeFavoritesModel.status == false) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ChangeFavorites2SuccessState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      print(DioHelper.dio.options.headers);

      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(FavoritesSuccessGetDataState());
    }).catchError((error) {
      print(error);
      emit(FavoritesErrorGetDataState());
    });
  }

  ShopLoginModel loginModel;

  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      // token:
      // 'iFvlK7Ut62pyuGosPvAlY5sgBs9OAviDv9hbOpaDxNppSE48WKgDYA6YWYFyht8zexJzXr',
      token: token,
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(DioHelper.dio.options.headers);
      emit(ProfileSuccessGetDataState());
      print(loginModel.data.name);
    }).catchError((error) {
      print(error);
      emit(ProfileErrorGetDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ProfileLoadingUpdateDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(DioHelper.dio.options.headers);
      emit(ProfileSuccessUpdateDataState(loginModel));
      print(loginModel.data.name);
    }).catchError((error) {
      print('Update Userdata Error! ->');
      print(error);
      emit(ProfileErrorUpdateDataState());
    });
  }
}
