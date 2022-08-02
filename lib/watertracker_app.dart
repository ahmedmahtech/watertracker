import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:watertracker/actions/history_actions.dart';

import 'package:watertracker/model/app_state.dart';
import 'package:watertracker/reducers/app_state_reducer.dart';
import 'package:watertracker/screens/home/home_page.dart';
import 'package:watertracker/middleware/middleware.dart';
import 'package:watertracker/actions/settings_actions.dart';

class WaterTracker extends StatelessWidget {
  final store = Store<AppState>(appReducer,
  initialState: AppState.defaultState(),
  middleware: createStoreMiddleware());

  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
  theme: ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF4C9BFB),
  ),
  home: StoreProvider(
  store: store,
  child: StoreBuilder<AppState>(
  onInit: (store) {
  store.dispatch(LoadDrinkHistoryAction());
  store.dispatch(LoadAppSettingsAction());
  },
  builder: (context, store) {
  return Material(
  type: MaterialType.transparency,
  child: HomePage(),
  );
  },
  ),
  ),
  );
  }
  }
