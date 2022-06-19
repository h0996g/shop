import 'package:flutter/material.dart';

Widget defaultForm(
        {required controller,
        required TextInputType type,
        required Function valid,
        required Text lable,
        Icon? prefixIcon,
        IconButton? sufixIcon,
        required TextInputAction textInputAction,
        bool obscureText = false,
        Function? onFieldSubmitted}) =>
    TextFormField(
      textInputAction: textInputAction,
      onFieldSubmitted: (k) {
        onFieldSubmitted!();
      },
      validator: (String? value) {
        return valid(value);
      },
      decoration: InputDecoration(
          label: lable,
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon),
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
    );
