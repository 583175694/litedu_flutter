import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_module/pages/calendar_page.dart';
import 'package:flutter_module/pages/archive_page.dart';
import 'package:flutter_module/pages/demo_page.dart';
import 'package:flutter_module/pages/evaluation_page.dart';
import 'test.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model/main_model.dart';

MainModel mainModel = MainModel();
void main() {
  runApp(MyApp(model: MainModel()));
}

class MyApp extends StatefulWidget {
  final MainModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
      'newsDetailPage': (String pageName, Map<dynamic, dynamic> params, String _) =>
          EmbeddedFirstRouteWidget()
    });
    FlutterBoost.singleton.addBoostNavigatorObserver(TestBoostNavigatorObserver());
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        title: '',
        builder: FlutterBoost.init(postPush: _onRoutePushed),
        home: CalendarPage(),
        routes: {
          "calendar_page": (context) => CalendarPage(),
          "archive_page": (context) => ArchivePage(),
          "evaluation_page": (context) => EvaluationPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
      ),
    );
  }

  void _onRoutePushed(
      String pageName,
      String uniqueId,
      Map<dynamic, dynamic> params,
      Route<dynamic> route,
      Future<dynamic> _,
      ) {}
}

class TestBoostNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPush');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didPop');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print('flutterboost#didRemove');
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print('flutterboost#didReplace');
  }
}