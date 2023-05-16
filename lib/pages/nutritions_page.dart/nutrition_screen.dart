import 'package:fitness_app/repository/firebase_service/cloud_firebase_service.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppBar(leftText: "Nutrition", rightText: "Screen"),
      ),
      body: BlocProvider(
        create: (context) =>
            FetchNutritionBloc(firebaseCloudService: FirebaseCloudService())
              ..add(LoadNutrition()),
        child: SingleChildScrollView(
          child: BlocConsumer<FetchNutritionBloc, FetchNutritionState>(
            listener: (context, state) {
              if (state is NutritionError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is NutritionLoading) {
                return const LoadingWidget(count: 10);
              }
              if (state is NutritionLoaded) {
                final food = state.nutritionModel.food;

                return Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormFieldWidget(
                          label: 'Search Foods!',
                          textEditingController: searchC,
                          icon: Icons.search),
                      const CustomBoldTitle(title: "About Nutrition"),
                      Container(
                          margin: EdgeInsets.all(5.h),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade300),
                          child: Text("${state.nutritionModel.about}",
                              style: Theme.of(context).textTheme.bodyLarge)),
                      const CustomBoldTitle(title: 'Nutrition Category'),
                      SizedBox(
                          height: 120.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return NutritionCardWidget(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/listNutrition',
                                        arguments: food
                                            ?.where((element) =>
                                                element.type ==
                                                food[index].type)
                                            .toList()),
                                    image: "${food?[index].image}",
                                    title: "${food?[index].type}");
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomBoldTitle(title: 'List of Foods'),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/listNutrition',
                                arguments: food),
                            style: Theme.of(context)
                                .textButtonTheme
                                .style!
                                .copyWith(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.all(20))),
                            child: const Text("See All"),
                          )
                        ],
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return NutritionFoodCardWidget(
                              onTap: () => Navigator.pushNamed(
                                  context, '/detailNutrition',
                                  arguments: food![index]),
                              title: "${food?[index].name}",
                              subTitle: "${food?[index].calories}",
                              image: "${food?[index].image}");
                        },
                      )
                    ],
                  ),
                );
              }
              return const Text("Theres Something Wrong");
            },
          ),
        ),
      ),
    );
  }
}
