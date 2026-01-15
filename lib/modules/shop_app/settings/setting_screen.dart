import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component/components.dart';
import 'package:shop_app/component/constants.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';
import 'package:shop_app/cubit/cubit.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserData) {
          nameController.text = state.profileModel.firstName ?? '';
          emailController.text = state.profileModel.email ?? '';
          phoneController.text = state.profileModel.phone ?? '';
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).profileModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                        value: AppCubit.get(context).isDark,
                        onChanged: (value) {
                          AppCubit.get(context).changeAppMode();
                        },
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  if (state is ShopLoadingUpdateUserData)
                    LinearProgressIndicator(),

                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      lable: 'Name',
                      prefix: Icons.person),
                  SizedBox(height: 20),

                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                      lable: 'Email Address',
                      prefix: Icons.mail),
                  SizedBox(height: 20),

                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      lable: 'Phone Number',
                      prefix: Icons.phone),
                  SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ShopLayoutCubit.get(context).updateUser(
                            id: CasheHelper.getData(key: 'userId'),
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      child: Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        SignOut(context);
                      },
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 30
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
