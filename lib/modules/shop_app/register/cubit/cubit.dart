import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/models/shop_app/register_model.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../../component/constants.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;


  void userRegister ({
    required String name,
    required String username,
    required String password,
    required String phone

  })
  {
    emit(ShopRegisterLoadingState());

    dioHelper.postData(
        url: REGESTER,
        data: {
          'name' : name,
          'username': username ,
          'password': password,
          'phone' : phone,
        }
    ).then((value){
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      CasheHelper.saveData(key: 'userName', value: registerModel!.username);
      CasheHelper.saveData(key: 'email', value: registerModel!.email);
      CasheHelper.saveData(key: 'phone', value: registerModel!.phone);

      emit(ShopRegisterSuccessState(registerModel!));

  }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterFailedState(error.toString()));
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