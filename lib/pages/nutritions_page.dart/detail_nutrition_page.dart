import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

class DetailNutritionPage extends StatelessWidget {
  final FoodModel foodModel;
  const DetailNutritionPage({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TitleAppBar(leftText: foodModel.name, rightText: "Page"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.h,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      AppUtils.appbarBackgroundColor,
                      AppUtils.gradientRightBackgroundColorDetailNutrition
                    ])),
                    child: Stack(children: [
                      Positioned(
                          top: 20.h,
                          left: 30.w,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  height: 200.h,
                                  width: 300.w,
                                  foodModel.image))),
                      Positioned(
                          bottom: -5.h,
                          child: Container(
                            height: 25.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                                color: Colors.white),
                          ))
                    ])),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomBoldTitle(title: foodModel.name),
                                CustomBoldTitle(
                                    title: "Type : ${foodModel.type}",
                                    fontWeight: FontWeight.w200,
                                    fontSize: 20.0),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite,
                                    color: Colors.red))
                          ]),
                      const SizedBox(height: 10.0),
                      const Divider(),
                      const SizedBox(height: 10.0),
                      const CustomBoldTitle(title: "Nutrition"),
                      _nutritionsCardWidget(foodModel),
                      const CustomBoldTitle(title: "Descriptions"),
                      Container(
                          margin: EdgeInsets.all(5.h),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade300),
                          child: Text(foodModel.description,
                              style: Theme.of(context).textTheme.bodyLarge)),
                      const CustomBoldTitle(title: "Calories"),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(foodModel.calories,
                              style: Theme.of(context).textTheme.bodyLarge)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  SingleChildScrollView _nutritionsCardWidget(FoodModel foodModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppUtils.appbarBackgroundColor),
              child: Text(foodModel.kcal,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15))),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppUtils.appbarBackgroundColor),
              child: Text(foodModel.protein,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15))),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppUtils.appbarBackgroundColor),
              child: Text(foodModel.fat,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15))),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppUtils.appbarBackgroundColor),
              child: Text(foodModel.carbo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15))),
        ],
      ),
    );
  }
}
