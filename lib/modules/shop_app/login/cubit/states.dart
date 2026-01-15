import 'package:shop_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialStates extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class ShopLoginSuccessState extends ShopLoginStates{
   final ShopLoginModel loginModel;
   ShopLoginSuccessState(this.loginModel);

}

class ShopLoginFailedState extends ShopLoginStates{
  late final String error;

  ShopLoginFailedState(this.error);
}

class changePasswordIcon extends ShopLoginStates{}