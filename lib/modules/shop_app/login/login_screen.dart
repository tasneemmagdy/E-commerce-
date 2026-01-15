import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/register_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

import '../../../component/components.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState) {
            CasheHelper.saveData(
                key: 'token',
                value: state.loginModel.accessToken
            ).then((value) {
              navigateAndFinish(
                  context,
                  ShopLayout()
              );
            });
          }
          else{
            if (state is ShopLoginFailedState){
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                      content: Text(
                          '  بياناتك غلط يمعلم'
                      ),
                    duration: Duration(
                        seconds: 2
                    ),
                  )
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text('login now to browse our offers',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith
                            (
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'email address',
                            hintText: 'example@domail.com',
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'password',
                              hintText: '************',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon:(
                                  IconButton(
                                      onPressed: (){
                                        ShopLoginCubit.get(context).changePasswordVisibility();
                                      },
                                      icon: Icon(
                                          ShopLoginCubit.get(context).suffix,
                                      )
                              )
                              ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value)
                          {
                          if(formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              username: emailController.text,
                              password: passwordController.text,
                            );
                          }
                          },
                          obscureText: ShopLoginCubit.get(context).isPassword,

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder: (context) =>Center(
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                if(formKey.currentState!.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                    username: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                                },
                                child: Text(
                                  'login'.toUpperCase(),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          fallback:(context) => Center(
                              child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text('Don\'t have an account? '),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text(
                                  'Register Now',
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
          );
        },
      ),
    );
  }
}

