import 'package:flutter/material.dart';

void navigateTo (context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    )
);

void navigateAndFinish (context , widget ) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
    (route){
      return false;
    }
);

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  required String? Function(String?) validate,
  required String lable,
  required IconData prefix

}
) => TextFormField(
  controller: controller,
  validator: validate,
  decoration: InputDecoration(
    labelText: lable,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
  ),
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
);
