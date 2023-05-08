import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final IconData icon;
  final bool isPassword;
  const CustomTextFormFieldWidget(
      {required this.label,
      required this.textEditingController,
      required this.icon,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autocorrect: false,
        controller: textEditingController,
        enableSuggestions: false,
        obscureText: isPassword == true ? true : false,
        decoration: InputDecoration(
            fillColor: Colors.grey.shade300,
            filled: true,
            labelText: label,
            suffixIcon: isPassword == true
                ? const Icon(Icons.remove_red_eye_outlined)
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0)))));
  }
}
