  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shop_app/cubit/cubit.dart';
  import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/carts/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/login_screen.dart';
  import 'package:shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
  import 'package:shop_app/shared/bloc_observer.dart';
  import 'package:shop_app/shared/network/local/cahse_helper.dart';
  import 'package:shop_app/shared/network/remote/dio_helper.dart';
  import 'package:shop_app/shared/network/themes.dart';

import 'component/constants.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();

    await CasheHelper.init();
    dioHelper.init();

    Widget widget;

  bool isDark = CasheHelper.getData(key: 'isDark')?? false;

  bool OnBoarding = CasheHelper.getData(key: 'OnBoarding') ?? false;



  String? accessToken = CasheHelper.getData(key: 'accessToken');
    if (accessToken != null) {
      token = accessToken;
    }

  if (OnBoarding != null){

    if (accessToken != null) widget = ShopLayout();
    else widget = LoginScreen();
  }
  else{
    widget = OnBoardingScreen();
  }

  print(OnBoarding);

    runApp( MyApp(
      isDark : isDark,
        startWidget : widget
    ));
  }

  class MyApp extends StatelessWidget {
    final bool isDark;
    final Widget startWidget;
     MyApp({
      required this.isDark,
       required this.startWidget
  });

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopLayoutCubit()..getHomeData()..getCategoryData()..getUserData()),
          BlocProvider(create: (context) => CartsCubit()),
          BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        ],
          child: BlocConsumer<AppCubit , AppCubitStates>(
            listener: (context , state){},
            builder: (context , state){
              return  MaterialApp(
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                  title: 'Shop App',
                  home: startWidget
              );
            },
          ),
        );

    }
  }
