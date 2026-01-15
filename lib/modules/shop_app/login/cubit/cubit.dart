import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/constants.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
 ShopLoginCubit() : super(ShopLoginInitialStates());

 static ShopLoginCubit get(context) => BlocProvider.of(context);

 late ShopLoginModel loginModel;


 void userLogin ({
  required String username,
  required String password,
})
 {
  emit(ShopLoginLoadingState());
  dioHelper.postData(
      url: LOGIN,
      data: {
       'username': username ,
       'password': password,
      }
  ).then((value){
   loginModel = ShopLoginModel.fromJson(value.data);

   token = loginModel.accessToken!;
   print("TOKEN FROM LOGIN: $token");


   print(value.data);

   print(loginModel.accessToken);
   CasheHelper.saveData(key: 'accessToken', value: loginModel.accessToken).then((value){
    CasheHelper.saveData(key: 'refreshToken', value: loginModel.refreshToken);
    CasheHelper.saveData(key: 'userId', value: loginModel.id);
    emit(ShopLoginSuccessState(loginModel));

   });



  }).catchError((error) {
   print(error.toString());
   emit(ShopLoginFailedState(error.toString()));
  });
 }


 IconData suffix = Icons.visibility_off ;
 bool isPassword = true;

 void changePasswordVisibility (){
  isPassword = !isPassword;
  suffix =isPassword? Icons.visibility_off: Icons.visibility;
  emit(changePasswordIcon());
 }

}