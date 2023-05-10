import 'package:fitness_app/utils/export_utils.dart';
import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';

class SuccessRegistrationPage extends StatelessWidget {
  const SuccessRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Container(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsUtil.manWomanPose),
                          fit: BoxFit.cover))),
              SizedBox(height: 20.h),
              Text("Welcome urName!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 5.h),
              SizedBox(
                  width: 240.w,
                  child: Text(
                      textAlign: TextAlign.center,
                      "You are all set now, let’s reach your goals together with us",
                      style: Theme.of(context).textTheme.bodyLarge)),
              SizedBox(height: 40.h),
              CustomButtonWidget(
                labelButton: 'Go To Home',
                icon: Icons.home_outlined,
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
