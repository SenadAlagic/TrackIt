import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/Meal/meal.dart';
import '../providers/goal_provider.dart';
import '../providers/ingredient_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/recommendation_provider.dart';
import '../providers/subscription_provider.dart';
import '../providers/tag_provider.dart';
import '../providers/users_meal_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import 'master_screen.dart';

class SubscriptionData {
  String? date;
  int? count;

  SubscriptionData(this.date, this.count);
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late GoalProvider _goalProvider;
  late IngredientProvider _ingredientProvider;
  late MealProvider _mealProvider;
  late TagProvider _tagProvider;
  late RecommendationProvider _recommendationProvider;
  late UsersMealsProvider _usersMealsProvider;
  late SubscriptionProvider _subscriptionProvider;
  final _chartKey = GlobalKey<SfCartesianChartState>();

  late List<Meal> mostPopularMeals;
  bool isLoading = true;

  int goals = 0;
  int ingredients = 0;
  int meals = 0;
  int tags = 0;
  List<SubscriptionData> purchases = [];

  @override
  void initState() {
    super.initState();
    _goalProvider = context.read<GoalProvider>();
    _ingredientProvider = context.read<IngredientProvider>();
    _mealProvider = context.read<MealProvider>();
    _tagProvider = context.read<TagProvider>();
    _mealProvider = context.read<MealProvider>();
    _recommendationProvider = context.read<RecommendationProvider>();
    _usersMealsProvider = context.read<UsersMealsProvider>();
    _subscriptionProvider = context.read<SubscriptionProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var goalNumber = await _goalProvider.getForReport();
      var ingredientNumber = await _ingredientProvider.getForReport();
      var mealNumber = await _mealProvider.getForReport();
      var tagNumber = await _tagProvider.getForReport();
      var mostPopularMealsResults =
          await _usersMealsProvider.getMostPopularMeals();

      List<SubscriptionData> tempPurchases = [];
      var subscriptionPurchases =
          await _subscriptionProvider.getGroupedByMonth();
      for (var item in subscriptionPurchases.entries) {
        tempPurchases.add(SubscriptionData(item.key, item.value));
      }

      setState(() {
        goals = goalNumber;
        ingredients = ingredientNumber;
        meals = mealNumber;
        tags = tagNumber;
        purchases = tempPurchases;
        mostPopularMeals = mostPopularMealsResults;
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
    return MasterScreen(
      title: "Reports",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildTitle(),
      _buildFirstRow(),
      const SizedBox(height: 20),
      _buildSecondRow(),
      _buildThirdRow(),
      _buildButtons(),
    ]));
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _drawDeleteRecommendationsButton(),
        const SizedBox(width: 10),
        _drawExportToPdfButton(),
      ],
    );
  }

  void exporToPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        build: (context) => pw.Column(
              children: [
                pw.Container(
                    child: pw.Image(pw.MemoryImage(
                        File('assets/images/trackItLogo.png')
                            .readAsBytesSync())),
                    height: 50),
                pw.Text(
                  'Report Section for TrackIt',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                    'In the following document some key insights into the business of TrackIt app can be seen. Currently the stats are:'),
                pw.SizedBox(height: 10),
                pw.Column(children: [
                  pw.Text('Number of meals in the database: $meals'),
                  pw.Text(
                      'Number of ingredients in the database: $ingredients'),
                  pw.Text('Number of tags in the database: $tags'),
                  pw.Text('Number of goals in the database: $goals'),
                  pw.SizedBox(height: 20),
                ], mainAxisAlignment: pw.MainAxisAlignment.start),
                pw.Text('A table representation of the in app purchases'),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  context: context,
                  headers: ['Date of year', 'Value'],
                  data: [
                    for (var i = 0; i < purchases.length; i++)
                      [purchases[i].date, purchases[i].count],
                  ],
                ),
              ],
            )));

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF Report',
      initialDirectory: "/",
      allowedExtensions: ['pdf'],
      fileName: 'trackIt_report.pdf',
    );

    if (result != null) {
      final file = File(result);
      await file.writeAsBytes(await pdf.save());
    }
  }

  Widget _drawExportToPdfButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () => exporToPdf(),
          child: const Text("Export to PDF")),
    );
  }

  Widget _drawMostPopularMeals() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          const Text(
            "Most popular meals",
            style: TextStyle(fontSize: 22),
          ),
          ...mostPopularMeals.map(
              (Meal meal) => SizedBox(width: 320, child: _drawMealCard(meal))),
        ],
      ),
    );
  }

  Padding _drawDeleteRecommendationsButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () async =>
              await _recommendationProvider.deleteAllRecommendation(),
          child: const Text("Delete recommender results")),
    );
  }

  Padding _buildTitle() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Text(
          "View TrackIt reports",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ));
  }

  Row _buildFirstRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer("Total number of meals:", meals),
      const SizedBox(width: 20),
      _buildContainer("Total number of ingredients:", ingredients),
      const SizedBox(width: 20),
    ]);
  }

  Row _buildSecondRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      _buildContainer("Total number of tags:", tags),
      const SizedBox(width: 20),
      _buildContainer("Total number of goals:", goals),
      const SizedBox(width: 20),
    ]);
  }

  Widget _buildThirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _drawMostPopularMeals(),
        const SizedBox(width: 20),
        _drawSubscriptionGraph()
      ],
    );
  }

  Widget _drawSubscriptionGraph() {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(children: [
          const Text(
            "Subscriptions per month",
            style: TextStyle(fontSize: 22),
          ),
          SfCartesianChart(
            key: _chartKey,
            backgroundColor: Colors.white,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(interval: 1),
            series: <CartesianSeries>[
              LineSeries<SubscriptionData, String>(
                  dataSource: purchases,
                  xValueMapper: (SubscriptionData sales, _) => sales.date,
                  yValueMapper: (SubscriptionData sales, _) => sales.count)
            ],
          )
        ]));
  }

  Widget _buildContainer(String hint, int number) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      height: 50,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("$hint $number", style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _drawMealCard(Meal meal) {
    return Card(
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
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      ]),
    );
  }
}
