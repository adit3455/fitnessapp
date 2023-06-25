import 'package:dartz/dartz.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:fitness_app/repository/firebase_exercise_module.dart/base_firebase_exercise_modul.dart';

import '../../models/failure_model.dart';

class FirebaseExerciseModule extends BaseFirebaseExerciseModule {
  Future<void> sendDoneExercise(
      {required String date,
      required String duration,
      required double totalCalories,
      required List<ExerciseModel> accomodateExercises}) async {
    try {
      final List<Map<String, dynamic>> dataExercise =
          accomodateExercises.map((e) => e.toMap()).toList();
      await db
          .collection('userExercise')
          .doc("${fbAuth.currentUser?.uid ?? fbAuth.currentUser!.displayName}")
          .collection(super.date)
          .doc("userFinished")
          .set({
        "date": date,
        "duration": duration,
        "month": int.parse(super.month),
        "day": int.parse(super.day),
        "totalCalories": totalCalories,
        "accomodateExercises": dataExercise
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  updateDoneExercise() async {
    final snapshot =
        await db.collection('').doc('').collection('collectionPath').get();
    print(snapshot);
  }

  Future<Either<List<ExerciseModel>, FailureModel>> getData() async {
    try {
      final snapshot =
          await db.collection('exercises').doc('allExercises').get();
      final data = snapshot.data() as Map<String, dynamic>;

      List inputMap = data['listExercise'];
      List<ExerciseModel> listOfExercise =
          inputMap.map((e) => ExerciseModel.fromMap(e)).toList();
      if (!snapshot.exists) {
        return Right(FailureModel(message: "Not found any of your data"));
      } else {
        return Left(listOfExercise);
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}


// List<ExerciseModel> list = <ExerciseModel>[
//     const ExerciseModel(
//         name: "Jumping Jacks",
//         instructions:
//             "Start with your feet together and your arms by your sides, then jump up with your feet apart and your hands overhead. Return to the start position then do the next rep. this exercise provides an full-body workout and works all your large muscle groups",
//         image:
//             "https://hips.hearstapps.com/hmg-prod/images/workouts/2016/03/jumpingjack-1457045563.gif",
//         calories: 8,
//         dificulities: "medium",
//         type: "fbworkout"),
//     const ExerciseModel(
//         name: "Standing Back Stretches",
//         calories: 2,
//         dificulities: "easy",
//         type: "ubworkout",
//         instructions:
//             "Stand with feet an litle wider than shoulder width apart. Raise your hands overhead with palms up toward the ceiling. Use one of your hands to grab the other. Bend your body side to side",
//         image:
//             "https://i0.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/325/325373/overhead-arm-reach-stretch-gif.gif?w=1155&h=840"),
//     const ExerciseModel(
//         name: "Kneeling Lunge Sretch Left",
//         calories: 2,
//         dificulities: "easy",
//         type: "lbworkout",
//         instructions:
//             "Starts in a push-up position. Bring your left knee forward and drop your right knee on the floor. \n Raise your upper body and put your hands on your waist. Then push your hips forward while keeping your upper body straight. \n Please make sure your from knee wont go over your toes. Hold this Position for a few seconds",
//         image:
//             "https://media1.popsugar-assets.com/files/thumbor/2vhiMaTfZc9vNpCrv4dY80BgDjU/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2020/12/29/688/n/1922729/1c96bfd9f5b9586b_IMB_CGsujC/i/Kneeling-Hip-Flexor-Stretch.GIF"),
//     const ExerciseModel(
//       calories: 2,
//       type: "lbworkout",
//       dificulities: "easy",
//       name: "Kneeling Lunge Sretch Right",
//       instructions:
//           "Starts in a push-up position. Bring your Right knee forward and drop your right knee on the floor. \n Raise your upper body and put your hands on your waist. Then push your hips forward while keeping your upper body straight. \n Please make sure your from knee wont go over your toes. Hold this Position for a few seconds",
//       image:
//           "https://i0.wp.com/post.greatist.com/wp-content/uploads/sites/2/2019/05/PERFECT-SERIES_LUNGE-HORIZONTAL_GRAIN.gif?w=1155&h=812",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "ubworkout",
//       name: "Calf Stretch Left",
//       instructions:
//           "Stand one big step away in front of a wall. Step forward with your right food and push the wall with your hands. \n Please make sure your leg is fully extended and you can feel your left calf strecthing. Hold this position for a few seconds",
//       image:
//           "https://post.greatist.com/wp-content/uploads/sites/2/2019/05/wall-calf-stretch-.gif",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "ubworkout",
//       name: "Calf Stretch Right",
//       instructions:
//           "Stand one big step away in front of a wall. Step forward with your left food and push the wall with your hands. \n Please make sure your right is fully extended and you can feel your right calf strecthing. Hold this position for a few seconds",
//       image: "https://thumbs.gfycat.com/AbsoluteKeyGoitered-max-1mb.gif",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "lbworkout",
//       name: "Knee To Chest Stretch Left",
//       instructions:
//           "Lie on the floor with your legs extended. Lift your knee up and grab it with both hands. \n Pull your left knee towards your chest as much as you can while keeping your right leg straight on the ground \n Hold this position for a few seconds.",
//       image: "https://thumbs.gfycat.com/AnxiousOffensiveLeafhopper-max-1mb.gif",
//     ),
//     const ExerciseModel(
//       name: "Knee To Chest Stretch Right",
//       calories: 2,
//       dificulities: "easy",
//       type: "lbworkout",
//       instructions:
//           "Lie on the floor with your legs extended. Lift your knee up and grab it with both hands. \n Pull your right knee towards your chest as much as you can while keeping your left leg straight on the ground \n Hold this position for a few seconds.",
//       image: "https://thumbs.gfycat.com/AnxiousOffensiveLeafhopper-max-1mb.gif",
//     ),
//     const ExerciseModel(
//       name: "Forward Spine Strecth",
//       calories: 3,
//       dificulities: "medium",
//       type: "fbworkout",
//       instructions:
//           "Sit on the floor with your feet hip width apart . Lift your arms at shoulder height, curl your chin towards your chest. \n As you exhale, draw your abdomen in and use your hands to reach your toes. Inhale and come back. Repeat it.",
//       image:
//           "https://thumbs.gfycat.com/AlertAfraidAldabratortoise-size_restricted.gif",
//     ),
//     const ExerciseModel(
//       calories: 3,
//       dificulities: "easy",
//       type: "fbworkout",
//       name: "Cat Cow Pose",
//       instructions:
//           "Start on all fours with your knees under your butt and your hands directly under your shoulders. \n Then take a breath and make your belly fall down, shoulders roll back and head come up towards the ceiling. \n As you exhale, curve your back upward and let your head come down. Repeat the exercise. Do it slowly with each step of this exercise.",
//       image: "https://media.tenor.com/-wXXHLdS4nYAAAAM/workout-working-out.gif",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "lbworkout",
//       name: "Wall Standing Glute Kickball Left",
//       instructions:
//           "Stand straight with your arms on a wall, then kick your left leg backwards and extend it as far as you can, meanwhile keep your legs and back straight and head up. \n Go back to the start position and repeat the exercise.",
//       image:
//           "https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_12/1691202/standing_glute_kickback.gif",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "lbworkout",
//       name: "Wall Standing Glute Kickball Right",
//       instructions:
//           "Stand straight with your arms on a wall, then kick your right leg backwards and extend it as far as you can, meanwhile keep your legs and back straight and head up. \n Go back to the start position and repeat the exercise.",
//       image:
//           "https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_12/1691202/standing_glute_kickback.gif",
//     ),
//     const ExerciseModel(
//       calories: 3,
//       dificulities: "easy",
//       type: "fbworkout",
//       name: "Downward Facing Dog",
//       instructions:
//           "Start on all fours with your knees under your butt and your hands directly under your shoulders. \n Straighten your legs and list your hips up in an upside down 'V' shape. spread your fingers. Transfer your weight back to your legs. Hold this position.",
//       image:
//           "https://24.media.tumblr.com/fb3785b6eab2ae346363dd00b08661c8/tumblr_n60xelhAoD1s2knnio1_500.gif",
//     ),
//     const ExerciseModel(
//       calories: 8,
//       dificulities: "hard",
//       type: "fbworkout",
//       name: "Plank",
//       instructions:
//           "Lie on the floor with your toes and forearms on the ground. keep your body straight and hold this position as long as you can. \n This exercise strengthens the abdomen, back and shoulders.",
//       image: "https://thumbs.gfycat.com/ShorttermPepperyDartfrog-max-1mb.gif",
//     ),
//     const ExerciseModel(
//       calories: 3,
//       dificulities: "medium",
//       type: "lbworkout",
//       name: "Butt Bridge",
//       instructions:
//           "Lie on your back with knees bent and feet flat. on the floor. Put your arms flat as your sides. \n Them lift your butt up and down.",
//       image:
//           "https://images-prod.healthline.com/hlcmsresource/images/topic_centers/Fitness-Exercise/648x364_5_Glute_Bridge_Variations_Press_Through_Toes.gif",
//     ),
//     const ExerciseModel(
//       calories: 4,
//       type: "lbworkout",
//       dificulities: "easy",
//       name: "Double Knees To Chest",
//       instructions:
//           "Lie down on your back with your legs extended. \n Bend your knees and bring them up toward your chest. Hug your own knees with both hands. Hold for a few seconds.",
//       image: "https://thumbs.gfycat.com/AdmirableNauticalCentipede-max-1mb.gif",
//     ),
//     const ExerciseModel(
//       calories: 5,
//       dificulities: "medium",
//       type: "fbworkout",
//       name: "Swimmer And Superman",
//       instructions:
//           "Lie on your stomatch with your arms extended straight overhead. ALternately lift your opposite arm and leg.",
//       image:
//           "https://images-prod.healthline.com/hlcmsresource/images/topic_centers/Fitness-Exercise/400x400_4_Easy_Back_Fat_Exercises_Swimmers.gif",
//     ),
//     const ExerciseModel(
//       calories: 5,
//       dificulities: "medium",
//       type: "fbworkout",
//       name: "Standing Bycicle Crunches",
//       instructions:
//           "Standing with your feet shoulder width apart. Bring your knee to your opposite elbow. \n Return to the start position and repeat with the other side.",
//       image:
//           "https://cdn-img.thethao247.vn/origin_768x0/storage/files/linhseo/2022/01/20/karena-standing-alternating-knee-to-elbow-crunch-1642648886.gif",
//     ),
//     const ExerciseModel(
//       calories: 2,
//       dificulities: "easy",
//       type: "lbworkout",
//       name: "Prone Flutter Kicks",
//       instructions:
//           "Lie on your stomatch with your legs extended and your chin on your arms. \n Lift your legs off the floorm then alternately lift your left and right legs.",
//       image:
//           "https://thumbs.gfycat.com/ComposedFoolishBats-size_restricted.gif",
//     ),
//     const ExerciseModel(
//       calories: 4,
//       dificulities: "medium",
//       type: "fbworkout",
//       name: "Lying Butterfly Stretch",
//       instructions:
//           "Lie on the floor with your feet together. Open your knees to the sides. Hold this position.",
//       image:
//           "https://img.huffingtonpost.com/asset/566b323b1600002c00eb8a34.gif?ops=scalefit_720_noupscale",
//     ),
//     const ExerciseModel(
//       calories: 3,
//       dificulities: "easy",
//       type: "fbworkout",
//       name: "Forward Bend",
//       instructions:
//           "Stand on the floor with your feet together. \n Then your body and bring your upper body as close to your legs as you can. \n Holds this position for an few seconds and repeat. \n Exhale when you bend your body and inhale when you come up. Keep up your legs straight during the exercise.",
//       image:
//           "https://www.vissco.com/wp-content/uploads/animation/sub/forward-bend-isometric.gif",
//     ),
//     const ExerciseModel(
//       calories: 8,
//       dificulities: "hard",
//       type: "lbworkout",
//       name: "Crunch Kick",
//       instructions:
//           "Lie on your back with your arms at your sides and shoulders slightly lifted. \n Raise your legs off the floor, bend your knees and pull them toward your chest. \n Kick your feet forward and repeat it.",
//       image: "https://media0.giphy.com/media/TMNCtgJGJnV8k/giphy.gif",
//     ),
//     const ExerciseModel(
//       calories: 12,
//       dificulities: "hard",
//       type: "fbworkout",
//       name: "Rope Jumping",
//       instructions:
//           "Hold the handles and put the jump rope behind your feet. \n Swing the jump rope over your head, jump up and let the rope pass under your feet.",
//       image:
//           "https://coveteur.com/media-library/image.gif?id=25368507&width=210",
//     ),
//     const ExerciseModel(
//       calories: 3,
//       dificulities: "easy",
//       type: "lbworkout",
//       name: "Calf Raise With Splayed Foot",
//       instructions:
//           "Stand with your feet shoulder width apart. Put your hands on the wall to maintain balance. \n  Twist your anckles to make your toes point outwards, then lift your heels up and down.",
//       image: "https://media.tenor.com/4LlIhz5Xhc0AAAAC/calf-calf-raise.gif",
//     ),
//     const ExerciseModel(
//       calories: 10,
//       dificulities: "hard",
//       type: "fbworkout",
//       name: "Jumping Squat",
//       instructions:
//           "Start in the squat position, then jump up using your abdominal muscles for strength. This exercise works your abdomen.",
//       image: "https://media.tenor.com/KTAavalOAWQAAAAC/squat-jumps.gif",
//     ),
//     const ExerciseModel(
//         name: "Triceps Dips",
//         instructions:
//             "Sit on sturdy chair and put both of your arms to the side of the chair. move your body up and down inhale and lower body until your elbows form a 90-degree angle.",
//         image:
//             "https://post.healthline.com/wp-content/uploads/2019/09/400x400_Cardio_and_Weights_to_Tone_Underarms_Bench_Dip.gif",
//         calories: 5,
//         dificulities: "medium",
//         type: "ubworkout"),
//     const ExerciseModel(
//         name: "Wall Angels",
//         instructions:
//             "Stand with your butt, upper back, shoulders, and head pressed firmly against a wall. Your feet can be slightly away from the wall to help you position your body correctly. Keep your knees slightly bent. \n Squeeze the muscles of your mid-back as you slide your arms down toward your shoulders. Keep your body pressed firmly against the wall throughout the movement.",
//         image:
//             "https://post.healthline.com/wp-content/uploads/2019/10/400x400_Exercises_to_Relieve_Upper_Back_Pain_Wall_Angels.gif",
//         calories: 4,
//         dificulities: "easy",
//         type: "ubworkout"),
//     const ExerciseModel(
//         name: "Mountain Climbers",
//         instructions:
//             "Get in a plank or pushup position. Keep your hands under your shoulders, with your core and glutes engaged, hips in line with shoulders, feet hip-width apart. \n Quickly bring your right knee in towards the chest. As you drive it back, pull the left knee in toward your chest.",
//         image:
//             "https://post.healthline.com/wp-content/uploads/2019/09/400x400_Benefits_of_Sit_Ups_and_How_to_Do_Them_Suspended_Mountain_Climbers.gif",
//         calories: 4,
//         dificulities: "medium",
//         type: "ubworkout"),
//   ];