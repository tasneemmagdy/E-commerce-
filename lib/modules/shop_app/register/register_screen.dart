import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context , state) {
          if(state is ShopRegisterSuccessState) {

              navigateAndFinish(
                  context,
                  ShopLayout()
              );

          }
          else{
            if (state is ShopRegisterFailedState){
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
        builder: (context , state){
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text('register now to browse our offers',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith
                            (
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'User Name',
                            hintText: 'Ahmed',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
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
                                      ShopRegisterCubit.get(context).changePasswordVisibility();
                                    },
                                    icon: Icon(
                                      ShopRegisterCubit.get(context).suffix,
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
                              ShopRegisterCubit.get(context).userRegister(
                                username: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,

                              );
                            }
                          },
                          obscureText: ShopRegisterCubit.get(context).isPassword,

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'phone Number',
                            hintText: '0123456789',
                            prefixIcon: Icon(
                              Icons.phone_android,
                            ),

                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'enter your phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (value)
                          {
                            if(formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                username: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          obscureText: ShopRegisterCubit.get(context).isPassword,

                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState ,
                          builder: (context) =>Center(
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  if(formKey.currentState!.validate()){
                                    ShopRegisterCubit.get(context).userRegister(
                                      username: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'register'.toUpperCase(),
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
