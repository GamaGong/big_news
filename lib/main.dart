import 'package:auto_route/auto_route.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/routing/Router.gr.dart' as routing;
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/locale.dart';
import 'package:big_news/state/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final appLocale =
      LocaleExtenstion.fromString(prefs.getString((AppLocale).toString()));
  final store = Store<AppState>(
    appReducer,
    middleware: [thunkMiddleware],
    initialState: AppState.initial(appLocale: appLocale),
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
        builder: ExtendedNavigator.builder(router: routing.Router()),
        locale: locale,
      ),
    ),
  ));
}
