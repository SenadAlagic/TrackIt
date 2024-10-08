import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ActivityLevel/activity_level.dart';
import '../models/search_result.dart';
import '../providers/activity_level_provider.dart';
import '../utils/alert_helpers.dart';
import '../utils/image_helpers.dart';
import '../widgets/PaginationWidget/pagination_widget.dart';
import 'activity_level_details_screen.dart';
import 'master_screen.dart';

class ManageActivityLevelsScreen extends StatefulWidget {
  const ManageActivityLevelsScreen({super.key});

  @override
  State<ManageActivityLevelsScreen> createState() =>
      _ManageActivityLevelsScreenState();
}

class _ManageActivityLevelsScreenState
    extends State<ManageActivityLevelsScreen> {
  final GlobalKey<PaginationWidgetState> _paginationKey =
      GlobalKey<PaginationWidgetState>();
  late ActivityLevelProvider _activityLevelProvider;
  SearchResult<ActivityLevel>? activityLevels;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _activityLevelProvider = context.read<ActivityLevelProvider>();
    initScreen();
  }

  Future initScreen() async {
    try {
      var result =
          await _activityLevelProvider.get(filter: {'Page': 0, 'PageSize': 5});
      setState(() {
        activityLevels = result;
        isLoading = false;
      });
    } on Exception catch (e) {
      if (context.mounted) {
        AlertHelpers.showAlert(context, "Error", e.toString());
      }
    }
  }

  void onActivityLevelAdded(ActivityLevel activityLevel) {
    setState(() {
      activityLevels!.result.add(activityLevel);
      activityLevels!.meta.count += 1;
    });
  }

  void onActivityLevelUpdated(ActivityLevel updatedActivityLevel) {
    var updatedActivityLevels = activityLevels;
    var indexOf = updatedActivityLevels!.result.indexWhere(
        (ActivityLevel activityLevel) =>
            activityLevel.activityLevelId ==
            updatedActivityLevel.activityLevelId);
    updatedActivityLevels.result[indexOf] = updatedActivityLevel;
    setState(() {
      activityLevels = updatedActivityLevels;
    });
  }

  void onResultFetched(SearchResult<dynamic> result) {
    setState(() {
      activityLevels = result as SearchResult<ActivityLevel>;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage activity levels",
      child: isLoading ? Container() : _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SingleChildScrollView(
              child: IntrinsicHeight(
                  child: Column(
            children: activityLevels!.result
                .map((goal) => _drawActivityLevelCard(goal))
                .toList(),
          ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivityLevelDetailsScreen(
                            onItemAdded: onActivityLevelAdded,
                          )))
                },
                child: const Card(
                  child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text("Add a new activity level")),
                ),
              )
            ],
          ),
          PaginationWidget(
              key: _paginationKey,
              activityLevels!,
              _activityLevelProvider,
              onResultFetched,
              5)
        ]));
  }

  Widget _drawActivityLevelCard(ActivityLevel activityLevel) {
    return Card(
      child: Row(children: [
        const SizedBox(
          height: 80,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16.0),
            child: ImageHelpers.getImage(activityLevel.image)),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activityLevel.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("${activityLevel.multiplier}x")
          ],
        )),
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivityLevelDetailsScreen(
                          activityLevel: activityLevel,
                          onItemUpdated: onActivityLevelUpdated)))
                },
            child: const Icon(Icons.create_outlined)),
        InkWell(
            onTap: () {
              _activityLevelProvider.delete(activityLevel.activityLevelId!);
              setState(() {
                activityLevels!.result.remove(activityLevel);
                activityLevels!.meta.count -= 1;
              });
              if (activityLevels!.result.isEmpty) {
                _paginationKey.currentState?.handleGoBack();
              }
            },
            child: const Icon(Icons.delete_outline)),
        const SizedBox(
          width: 16,
        )
      ]),
    );
  }
}
