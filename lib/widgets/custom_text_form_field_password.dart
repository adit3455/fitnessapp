import 'package:flutter/material.dart';

class CustomTextFormFieldPassword extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function()? onPressedPass;
  @override
  const CustomTextFormFieldPassword(
      {this.onPressedPass,
      required this.validator,
      required this.textEditingController,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        autocorrect: false,
        controller: textEditingController,
        enableSuggestions: false,
        obscureText: isPassword == false ? false : true,
        decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            labelText: "Password",
            suffixIcon: IconButton(
                onPressed: onPressedPass,
                icon: Icon(isPassword == false
                    ? Icons.visibility_off
                    : Icons.visibility)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0)))));
  }
}
