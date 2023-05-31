import 'package:fitness_app/pages/exercises_pages/exercise_detail_page.dart';
import 'package:fitness_app/repository/export_repo.dart';
import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../config/export_config.dart';
import '../../widgets/export_widgets.dart';

class AllExercisesPage extends StatelessWidget {
  const AllExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleAppBar(leftText: "All", rightText: "Exercise"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (context) =>
            FetchExerciseBloc(firebaseExerciseModule: FirebaseExerciseModule())
              ..add(LoadExercise()),
        child: BlocConsumer<FetchExerciseBloc, FetchExerciseState>(
          listener: (context, state) {
            if (state is ExerciseError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is ExerciseLoading) {
              return const LoadingWidget(count: 1);
            } else if (state is ExerciseLoaded) {
              return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final exercise = state.listExercise[index];
                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExerciseDetailPage(
                                  index: index, exercise: exercise))),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(exercise.image,
                            fit: BoxFit.fitWidth, height: 130.h, width: 100.w),
                      ),
                      title: Text(exercise.name),
                      subtitle: Text(
                          "1 Minute : ${exercise.calories.toInt()} Calories | Dificulities : ${ExerciseConfig().capitalize(exercise.dificulities)}"),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: state.listExercise.length);
            }
            return const Text("Theres Something Wrong");
          },
        ),
      )),
    );
  }
}
