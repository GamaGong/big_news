import 'package:auto_route/auto_route.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/routing/Router.gr.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/locale.dart';
import 'package:big_news/state/reducers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial()
  );

  runApp(StoreProvider<AppState>(
    store: store,
    child: StoreConnector<AppState, Locale>(
      distinct: true,
      converter: (store) => store.state.appLocale.locale,
      builder: (_, locale) => MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: ExtendedNavigator.builder(router: Router()),
        locale: locale,
      ),
    ),
  ));
}
