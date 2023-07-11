import 'package:card_loading/card_loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/obscure_form_cubit/obscure_form_cubit.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_divider_with_text.dart';
import '../../widgets/custom_text_form_field_password.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, '/successRegis');
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
                    6,
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
                  top: true,
                  child: Form(
                    key: formKey,
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
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return 'Enter Correct First Name!';
                              }
                              return null;
                            },
                            icon: Icons.person_outline,
                            label: "First Name",
                            textEditingController: firstNameController),
                        SizedBox(height: 10.h),
                        CustomTextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return 'Enter Correct Last Name!';
                              }
                              return null;
                            },
                            icon: Icons.person_outline,
                            label: "Last Name",
                            textEditingController: lastNameController),
                        SizedBox(height: 10.h),
                        CustomTextFormFieldWidget(
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                      .hasMatch(value)) {
                                return 'Enter Correct Email!';
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
                        SizedBox(height: 20.h),
                        CustomButtonWidget(
                            labelButton: "Register",
                            icon: Icons.login,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignUpRequested(
                                    emailController.text,
                                    passController.text,
                                    firstNameController.text,
                                    lastNameController.text));
                              }
                            }),
                        const CustomDividerWithText(text: "Or"),
                        Container(
                            margin: EdgeInsets.all(10.h),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () => context
                                    .read<AuthBloc>()
                                    .add(GoogleSignInRequested()),
                                child: Logo(Logos.google))),
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
                                      ..onTap = () => Navigator.pushNamed(
                                          context, "/login"))
                              ])),
                        ),
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
