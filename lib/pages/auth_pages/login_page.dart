import 'package:fitness_app/blocs/export_blocs.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../widgets/export_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/');
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return Column(
                children: List.generate(
                    4,
                    (index) => const CardLoading(
                          height: 60,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          margin: EdgeInsets.symmetric(vertical: 5),
                        )));
          }
          if (state is UnAuthenticated) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0.h),
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        Text("Hey There,",
                            style: Theme.of(context).textTheme.headlineSmall),
                        Text("Welcome Back!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        SizedBox(height: 20.h),
                        CustomTextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                      .hasMatch(value)) {
                                return 'Input Correct Email';
                              }
                              return null;
                            },
                            icon: Icons.email_outlined,
                            label: "Email",
                            textEditingController: emailController),
                        SizedBox(height: 10.h),
                        BlocBuilder<ObscureFormCubit, ObscureFormState>(
                            builder: (context, state) {
                          return CustomTextFormFieldPassword(
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                        .hasMatch(value)) {
                                  return 'Input Correct Password. Ex: "Hifromapp#1"';
                                }
                                return null;
                              },
                              textEditingController: passController,
                              isPassword:
                                  (state as ObscureFormInitial).isPassword,
                              onPressedPass: () {
                                context
                                    .read<ObscureFormCubit>()
                                    .onChangingObscure(
                                        isPassword: !(state).isPassword);
                              });
                        }),
                        SizedBox(height: 10.h),
                        TextButton(
                            style: Theme.of(context)
                                .textButtonTheme
                                .style!
                                .copyWith(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.all(0))),
                            onPressed: () {},
                            child: Text(
                              "Forgot Your Password?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.grey.shade600),
                            )),
                        SizedBox(height: 150.h),
                        CustomButtonWidget(
                            labelButton: "Login",
                            icon: Icons.login_outlined,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignInRequested(
                                    emailController.text, passController.text));
                              }
                            }),
                        const CustomDividerWithText(text: "Or"),
                        Container(
                            width: 200.w,
                            padding: EdgeInsets.all(10.h),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  text: "Don't have an account yet? ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(
                                    style: const TextStyle(color: Colors.blue),
                                    text: 'Register',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushNamed(
                                          context, '/register'))
                              ])),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text("Theres Something Wrong");
        },
      ),
    );
  }
}
