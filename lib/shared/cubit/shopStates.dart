import 'package:ecommerce/models/changeFavoritesModel.dart';
import 'package:ecommerce/models/userModel.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

//Authentication States
class ShopLoadingState extends ShopStates {}
class ShopSuccessState extends ShopStates {
  userModel model;
  ShopSuccessState(this.model);
}
class ShopErrorState extends ShopStates {
  final String error;
  ShopErrorState(this.error);
}

//register
class ShopRegisterLoadingState extends ShopStates {}
class ShopRegisterSuccessState extends ShopStates {
  userModel model;
  ShopRegisterSuccessState(this.model);
}
class ShopRegisterErrorState extends ShopStates {
  final String error;
  ShopRegisterErrorState(this.error);
}

//update
class ShopUpdateLoadingState extends ShopStates {}
class ShopUpdateSuccessState extends ShopStates {
  userModel model;
  ShopUpdateSuccessState(this.model);
}
class ShopUpdateErrorState extends ShopStates {
  final String error;
  ShopUpdateErrorState(this.error);
}

//Home States
class ShopHomeLoadingState extends ShopStates {}
class ShopHomeSuccessState extends ShopStates {}
class ShopHomeErrorState extends ShopStates {
  final String error;
  ShopHomeErrorState(this.error);
}

//Categorey
class ShopCategoryLoadingState extends ShopStates {}
class ShopCategorySuccessState extends ShopStates {}
class ShopCategoryErrorState extends ShopStates {
  final String error;
  ShopCategoryErrorState(this.error);
}
class ShopCategoryProductsLoadingState extends ShopStates {}
class ShopCategoryProductsSuccessState extends ShopStates {}
class ShopCategoryProductsErrorState extends ShopStates {
  final String error;
  ShopCategoryProductsErrorState(this.error);
}

//favorites
class ShopChangeFavoritesIconSuccessState extends ShopStates {}
class ShopChangeFavoritesSuccessState extends ShopStates {
  final changeFavoritesModel model;
  ShopChangeFavoritesSuccessState(this.model);
}
class ShopChangeFavoritesErrorState extends ShopStates {
  final String error;
  ShopChangeFavoritesErrorState(this.error);
}
class ShopFavoritesLoadingState extends ShopStates {}
class ShopFavoritesSuccessState extends ShopStates {}
class ShopFavoritesErrorState extends ShopStates {
  final String error;
  ShopFavoritesErrorState(this.error);
}

//profile
class ShopProfileLoadingState extends ShopStates {}
class ShopProfileSuccessState extends ShopStates {
    userModel model;
  ShopProfileSuccessState(this.model);
}
class ShopProfileErrorState extends ShopStates {
  final String error;
  ShopProfileErrorState(this.error);
}

//Methods
class ChangeVisiableState extends ShopStates {}
class ChangeNavBarState extends ShopStates {}
