import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../widgets/export_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0.h),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),
                Text("Hey There,",
                    style: Theme.of(context).textTheme.headlineSmall),
                Text("Create an Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                CustomTextFormFieldWidget(
                    icon: Icons.person_outline,
                    label: "First Name",
                    textEditingController: firstNameController),
                SizedBox(height: 10.h),
                CustomTextFormFieldWidget(
                    icon: Icons.person_outline,
                    label: "Last Name",
                    textEditingController: lastNameController),
                SizedBox(height: 10.h),
                CustomTextFormFieldWidget(
                    icon: Icons.email_outlined,
                    label: "Email",
                    textEditingController: emailController),
                SizedBox(height: 10.h),
                CustomTextFormFieldWidget(
                    label: "Password",
                    textEditingController: passController,
                    icon: Icons.lock_outline_rounded,
                    isPassword: true),
                SizedBox(height: 10.h),
                TextButton(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(0))),
                    onPressed: () {},
                    child: Text(
                      "Forgot Your Password?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey.shade600),
                    )),
                SizedBox(height: 20.h),
                CustomButtonWidget(
                    labelButton: "Register",
                    icon: Icons.login,
                    onPressed: () {}),
                const CustomDividerWithText(text: "Or"),
                Container(
                    width: 200.w,
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {},
                              child: Logo(Logos.google)),
                          InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {},
                              child: Logo(Logos.facebook_f))
                        ])),
                Padding(
                  padding: EdgeInsets.all(10.h),
                  child: RichText(
                      text: TextSpan(
                          text: "Already have an Account? ",
                          style: const TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            style: const TextStyle(color: Colors.blue),
                            text: 'Login',
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Navigator.pushNamed(context, "/login"))
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
