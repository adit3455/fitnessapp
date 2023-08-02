import 'package:fitness_app/blocs/nutrition_bookmarks_bloc/nutrition_bookmarks_bloc.dart';
import 'package:fitness_app/widgets/loading_widget.dart';
import 'package:fitness_app/widgets/nutrition_food_card_widget.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteNutrition extends StatelessWidget {
  const FavoriteNutrition({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionBookmarksBloc, NutritionBookmarksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title:
                  const TitleAppBar(leftText: "Favorite", rightText: "Foods!"),
              centerTitle: true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _alertTop(context),
                  const SizedBox(height: 20),
                  if (state is NutritionBookmarksLoading) ...[
                    const LoadingWidget(count: 3)
                  ],
                  if (state is NutritionBookmarksLoaded) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.lFoodModel.length,
                      itemBuilder: (context, index) {
                        return NutritionFoodCardWidget(
                          onTap: () => Navigator.pushNamed(
                              context, '/detailNutrition',
                              arguments: state.lFoodModel[index]),
                          title: state.lFoodModel[index].name,
                          subTitle: state.lFoodModel[index].calories,
                          image: state.lFoodModel[index].image,
                          trailing: IconButton(
                              onPressed: () {
                                context.read<NutritionBookmarksBloc>().add(
                                    DeleteNutritionEvent(
                                        foodModel: state.lFoodModel[index]));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Removed From Bookmarks")));
                              },
                              icon: const Icon(Icons.remove_circle_outline)),
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Card _alertTop(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10.0),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              const Expanded(
                  flex: 1, child: Icon(Icons.fastfood_outlined, size: 30.0)),
              SizedBox(width: 10.w),
              Expanded(
                flex: 6,
                child: Container(
                    width: 270.w,
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Your Favorites Foods. Set it to be the Best Nutrition you can get!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              )
            ])));
  }
}
