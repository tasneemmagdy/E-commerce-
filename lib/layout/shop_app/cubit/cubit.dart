import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/product_model.dart';
import 'package:shop_app/models/shop_app/profile_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/Favorites_Screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/search/search_screen.dart';
import 'package:shop_app/modules/shop_app/settings/setting_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../component/constants.dart';
import '../../../models/shop_app/category_model.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{

  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomNavBarScreens =
  [
    ProductsScreen(),
    FavoritesScreen(),
    CategoriesScreen(),
    SettingScreen(),
    SearchScreen(),
  ];

  void changeBottomNavBarScreens(int index){
    currentIndex = index;
    emit(changeBottomNavBarState());
  }

  ProductModel? productModel;
  Map <int , bool> favorite = {};


  void getHomeData(){
    emit(ShopLoadingHomeData());

    dioHelper.getData(
        url: PRODUCT,
      token: token,
    ).then((value)
    {
      productModel = ProductModel.fromJson(value.data);

      productModel!.products!.forEach((element){
        favorite.addAll(
          {
            element.id! : element.inFavorites ,
          });
      });

      printFullText(productModel!.products![0].title!);
      emit(ShopSuccessHomeData());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopFailedHomeData());
    });
  }


 List <CategoryModel> categoryModel = [];

  void getCategoryData(){
    dioHelper.getData(
        url: CATEGORY,
      token: token,
    ).then((value){
      categoryModel = (value.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      emit(ShopSuccessCategoryModelData());
    }).catchError((error){
      print(error.toString());
      emit(ShopFailedCategoryModelData());
    });
  }

  void changeFavorites(int productId){

    var product = productModel!.products!.firstWhere((item) =>
        item.id == productId
    );
    product.inFavorites = !product.inFavorites;

    favorite[productId] = product.inFavorites;

    CasheHelper.saveData(
        key: 'favorite_$productId',
        value:  favorite[productId]
    );

    emit(ShopChangeFavoriteState());

  }

  void loadFavoritesFromCache() {
    productModel?.products?.forEach((product) {
      final storedValue = CasheHelper.getData(key: 'favorite_${product.id}');
      if (storedValue != null) {
        favorite[product.id!] = storedValue;
        product.inFavorites = storedValue;
      }
    });
  }


  ProfileModel? profileModel;


  void getUserData(){

    emit(ShopLoadingUserData());
    print('TOKEN BEFORE GET USER DATA: $token');

    dioHelper.getData(
        url: PROFILE,
      token: token
    ).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      printFullText(profileModel!.firstName!);
      emit(ShopSuccessUserData(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopFailedUserData());
    });
}

void updateUser({
  required int id,
  required String name,
  required String email,
  required String phone,
})
{
  emit(ShopLoadingUpdateUserData());

  dioHelper.putData(
      url:'users/$id',
    token: token,
      query: {
        'firstName': name,
        'email': email,
        'phone': phone,
      },
  ).then((value){
    profileModel = ProfileModel.fromJson(value.data);
    CasheHelper.saveData(key: 'userName', value: profileModel!.firstName);
    CasheHelper.saveData(key: 'email', value: profileModel!.email);
    CasheHelper.saveData(key: 'phone', value: profileModel!.phone);

    emit(ShopSuccessUpdateUserData(profileModel!));

  }).catchError((error){
    emit(ShopFailedUpdateUserData());

  });
}



}

