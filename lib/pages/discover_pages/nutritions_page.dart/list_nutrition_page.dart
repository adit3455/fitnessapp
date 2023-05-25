import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

class ListNutritionPage extends StatelessWidget {
  final List<FoodModel> foodModel;
  const ListNutritionPage({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppBar(leftText: "List of", rightText: "Foods"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Showing the Foods",
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text("Total ${foodModel.length}",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NutritionFoodCardWidget(
                        onTap: () => Navigator.pushNamed(
                            context, '/detailNutrition',
                            arguments: foodModel[index]),
                        title: foodModel[index].name,
                        subTitle: foodModel[index].calories,
                        image: foodModel[index].image);
                  },
                  itemCount: foodModel.length)
            ],
          ),
        ),
      ),
    );
  }
}
