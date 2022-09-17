import 'package:ecommerce/components/components.dart';
import 'package:ecommerce/components/conistants.dart';
import 'package:ecommerce/models/categoryModel.dart';
import 'package:ecommerce/models/categorydataModel.dart';
import 'package:ecommerce/models/changeFavoritesModel.dart';
import 'package:ecommerce/models/favoritesModel.dart';
import 'package:ecommerce/models/homeModel.dart';
import 'package:ecommerce/models/userModel.dart';
import 'package:ecommerce/screens/categories_screen/categoriesScreen.dart';
import 'package:ecommerce/screens/favorites_screen/favoritesScreen.dart';
import 'package:ecommerce/screens/home_screen/homeScreen.dart';
import 'package:ecommerce/screens/settings_screen/settingsScreen.dart';
import 'package:ecommerce/shared/Cache/cacheHelper.dart';
import 'package:ecommerce/shared/Dio/dioHelper.dart';
import 'package:ecommerce/shared/cubit/shopStates.dart';
import 'package:ecommerce/shared/endPoints/endPoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/login_screen/loginScreen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  Map<int, bool> favorites = {};
//models
  userModel? model;
  homeModel? homemodel;
  categoryModel? categorymodel;
  favoritesModel? favoritesmodel;
  categorydataModel? categorydatamodel;
  DataCategoryModel? dataCategoryModel;
  changeFavoritesModel? changefavorittesmodel;
  cacheHelper? cachemodel;
  int? CategoryId;

//get Home data
  void getHome() async {
    emit(ShopHomeLoadingState());
    await dioHelper.getData(url: HOME, token: token).then((value) {
      homemodel = homeModel.fromJson(value.data);
      homemodel!.data!.products!.forEach((element) {
        favorites.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState(error.toString()));
    });
  }

//get Categories data
  void getCategory() async {
    emit(ShopCategoryLoadingState());
    await dioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categorymodel = categoryModel.fromJson(value.data);
      emit(ShopCategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoryErrorState(error.toString()));
    });
  }

//get Favorites data
  void getFavorites() {
    emit(ShopFavoritesLoadingState());
    dioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesmodel = favoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesErrorState(error.toString()));
    });
  }

//get profile
  void getProfile() {
    emit(ShopProfileLoadingState());
    dioHelper.getData(url: PROFILE, token: token).then((value) {
      model = userModel.fromJson(value.data);
      emit(ShopProfileSuccessState(model!));
    }).catchError((error) {
      print((error).toString());
      emit(ShopProfileErrorState(error.toString()));
    });
  }

//signout
  void signOut(context) {
    cacheHelper.removeData(key: 'token').then((value) {
      navigatePush(context, loginScreen());
      currentIndex = 0;
    });
  }

//favoritesChange
  void changeFavorites(int? productId) {
    if (favorites[productId] == false && favorites[productId] != null) {
      favorites[productId!] = true;
    } else {
      favorites[productId!] = false;
    }
    emit(ShopChangeFavoritesIconSuccessState());
    dioHelper
        .postData(url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changefavorittesmodel = changeFavoritesModel.fromJson(value.data);
      getFavorites();
      emit(ShopChangeFavoritesSuccessState(changefavorittesmodel!));
    }).catchError((error) {
      emit(ShopChangeFavoritesErrorState(error.toString()));
      print(error.toString());
    });
  }

  //Categoriesitems
  void getCategoryProducts(dynamic categoryID) {
    emit(ShopCategoryProductsLoadingState());
    dioHelper
        .getData(
      url: PRODUCTS + categoryID.toString(),
    )
        .then((value) {
      categorydatamodel = categorydataModel.fromJson(value.data);
      emit(ShopCategoryProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoryProductsErrorState(error.toString()));
    });
  }

//login post
  void userLogin({required String email, required String password}) {
    emit(ShopLoadingState());
    dioHelper.postData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value) {
      model = userModel.fromJson(value.data);
      emit(ShopSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error.toString()));
    });
  }

//register post
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    dioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data.toString());
      model = userModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

//update post
  void userUpdate({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateLoadingState());
    dioHelper.putData(token: token, url: UPDATE, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      print(value.data.toString());
      print(token.toString());
      model = userModel.fromJson(value.data);
      emit(ShopUpdateSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateErrorState(error.toString()));
    });
  }

//change NavBar
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    categoriesScreen(),
    favoritesScreen(),
    settingsScreen()
  ];
  ChangeNav(int index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }

//change password
  bool isVis = true;
  Icon visiable = Icon(Icons.visibility_outlined);
  changeVis() {
    if (isVis == true) {
      isVis = false;
      visiable = Icon(Icons.visibility_off_outlined);
    } else {
      isVis = true;
      visiable = Icon(Icons.visibility_outlined);
    }
    emit(ChangeVisiableState());
  }
}
