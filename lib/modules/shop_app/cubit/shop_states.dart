import 'package:udemy_flutter/models/shop_app/change_favorites_model.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class NavBarIndexChangerState extends ShopStates {}

class HomeLoadingGetDataState extends ShopStates {}

class HomeSuccessGetDataState extends ShopStates {}

class HomeErrorGetDataState extends ShopStates {}

class CategorySuccessGetDataState extends ShopStates {}

class CategoryErrorGetDataState extends ShopStates {}

class ChangeFavoritesSuccessState extends ShopStates {}

class ChangeFavorites2SuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ChangeFavorites2SuccessState(this.model);
}

class ChangeFavoritesErrorState extends ShopStates {}

class FavoritesSuccessGetDataState extends ShopStates {}

class FavoritesErrorGetDataState extends ShopStates {}

class ProfileSuccessGetDataState extends ShopStates {}

class ProfileErrorGetDataState extends ShopStates {}

class ProfileErrorUpdateDataState extends ShopStates {}

class ProfileSuccessUpdateDataState extends ShopStates {
  final ShopLoginModel model;

  ProfileSuccessUpdateDataState(this.model);
}

class ProfileLoadingUpdateDataState extends ShopStates {}
