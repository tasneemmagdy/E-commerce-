import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';

import '../shared/network/local/cahse_helper.dart';

class AppCubit extends Cubit <AppCubitStates> {

  AppCubit () : super(AppCubitInitialState());

  static AppCubit get (context) => BlocProvider.of(context);
   bool isDark = false;
   ThemeMode appMode =ThemeMode.dark;

  void changeAppMode({bool? fromShared}){
    if(fromShared !=null){
      isDark =fromShared;
      emit(changeAppModeState());
    }
    else{
      isDark = !isDark;
      CasheHelper.saveData(
          key: 'isDark',
          value: isDark
      ).then((value) {
        emit(changeAppModeState());
      });
    }
  }



}