import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/obscure_form_cubit/obscure_form_cubit.dart';
import '../../utils/app_utils.dart';
import '../../widgets/custom_text_form_field_password.dart';
import '../../widgets/title_app_bar.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passC = TextEditingController();
    TextEditingController passConfirmC = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
          title: const TitleAppBar(leftText: "Change", rightText: "Password")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Type your password below",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 5.0),
                BlocBuilder<ObscureFormCubit, ObscureFormState>(
                  builder: (context, state) {
                    return CustomTextFormFieldPassword(
                        isPassword: (state as ObscureFormInitial).isPassword,
                        onPressedPass: () {
                          context.read<ObscureFormCubit>().onChangingObscure(
                              isPassword: !(state).isPassword);
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value)) {
                            return 'Passwords should contain three of the four character types: Uppercase letters: A-Z. Lowercase letters: a-z. Numbers: 0-9.';
                          }
                          return null;
                        },
                        textEditingController: passC);
                  },
                ),
                const SizedBox(height: 20.0),
                Text("Confirm your Password below",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 5.0),
                BlocProvider(
                  create: (context) => ObscureFormCubit(),
                  child: BlocBuilder<ObscureFormCubit, ObscureFormState>(
                    builder: (context, state) {
                      return CustomTextFormFieldPassword(
                          isPassword: (state as ObscureFormInitial).isPassword,
                          onPressedPass: () {
                            context.read<ObscureFormCubit>().onChangingObscure(
                                isPassword: !(state).isPassword);
                          },
                          labelPassword: "Confirm Password",
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                              return 'Passwords should contain three of the four character types: Uppercase letters: A-Z. Lowercase letters: a-z. Numbers: 0-9.';
                            }
                            if (passC.text != value) {
                              return "the types of Password and Confirm Password isn't Match";
                            }
                            return null;
                          },
                          textEditingController: passConfirmC);
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Notifications"),
                              elevation: 2,
                              titleTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                  color: Colors.grey),
                              content: const Text(
                                  "Are you sure want to change your password?"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            AppUtils.appbarBackgroundColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: const Text("Cancel",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                                TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.currentUser!
                                          .updatePassword(passConfirmC.text);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                            AppUtils.appbarBackgroundColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    child: const Text("Change Password",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)))
                              ],
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppUtils.appbarBackgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text("Change Password",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
