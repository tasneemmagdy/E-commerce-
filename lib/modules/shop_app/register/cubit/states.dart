import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialStates extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  final RegisterModel registerModel;
  ShopRegisterSuccessState(this.registerModel);

}

class ShopRegisterFailedState extends ShopRegisterStates{
  late final String error;

  ShopRegisterFailedState(this.error);
}

class changePasswordIcon extends ShopRegisterStates{}