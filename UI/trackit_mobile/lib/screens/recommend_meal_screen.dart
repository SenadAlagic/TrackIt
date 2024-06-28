import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit_mobile/utils/form_helpers.dart';

import '../models/Meal/meal.dart';
import '../providers/recommendation_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import '../utils/user_info.dart';
import 'master_screen.dart';
import 'meal_details_screen.dart';

class RecommendMealScreen extends StatefulWidget {
  const RecommendMealScreen({super.key});

  @override
  State<RecommendMealScreen> createState() => _RecommendMealScreenState();
}

class _RecommendMealScreenState extends State<RecommendMealScreen> {
  late RecommendationProvider _recommendationProvider;

  Meal? recommendedMeal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _recommendationProvider = context.read<RecommendationProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      if (UserInfo.lastLoggedMealId == null ||
          (UserInfo.user?.isUserPremium == false)) {
        return;
      }

      var result =
          await _recommendationProvider.get(UserInfo.lastLoggedMealId!);

      setState(() {
        recommendedMeal = result;
        isLoading = false;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(child: _buildScreen());
  }

  Widget _buildScreen() {
    if (isLoading == true) {
      return FormHelpers.drawProgressIndicator();
    }
    if (UserInfo.lastLoggedMealId == null) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(children: [
          Text("For best results you have to log at least one meal for today",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
                "In order for the recommender system to work best, it's recommended that you consume/log at least one meal before seeking a recommendation.",
                textAlign: TextAlign.center),
          )
        ]),
      );
    }
    if (!UserInfo.user!.isUserPremium!) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(children: [
          Text(
            "You have to be a premium member in order to access this feature",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                "You have to be a premium member in order to access this feature. You can do so by purchasing the account upgrade for the price of \$4.99.",
                textAlign: TextAlign.center,
              ))
        ]),
      );
    }
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text("The meal we recommend...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        _drawMealCard(recommendedMeal!),
      ],
    );
  }

  Widget _drawMealCard(Meal meal) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => MealDetailsScreen(meal: meal)))),
          child: Row(children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16.0),
                child: ImageHelpers.getImage(meal.image)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name ?? "",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    padding: const EdgeInsets.only(right: 13.0),
                    child: Text(
                      meal.description ?? "",
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            )),
            const SizedBox(
              width: 16,
            )
          ]),
        ));
  }
}
