import 'package:shop_app/models/shop_app/profile_model.dart';

abstract class ShopLayoutStates{}

class ShopLayoutInitialState extends ShopLayoutStates {}

class changeBottomNavBarState extends ShopLayoutStates{}

class ShopLoadingHomeData extends ShopLayoutStates{}

class ShopSuccessHomeData extends ShopLayoutStates{}

class ShopFailedHomeData extends ShopLayoutStates{}

class ShopSuccessCategoryModelData extends ShopLayoutStates{}

class ShopFailedCategoryModelData extends ShopLayoutStates{}

class ShopChangeFavoriteState extends ShopLayoutStates{}

class ShopLoadingUserData extends ShopLayoutStates{}

class ShopSuccessUserData extends ShopLayoutStates{
  final ProfileModel profileModel;
  ShopSuccessUserData(this.profileModel);
}

class ShopFailedUserData extends ShopLayoutStates{}

class ShopLoadingUpdateUserData extends ShopLayoutStates{}

class ShopSuccessUpdateUserData extends ShopLayoutStates{
  final ProfileModel profileModel;
  ShopSuccessUpdateUserData(this.profileModel);
}

class ShopFailedUpdateUserData extends ShopLayoutStates{}
