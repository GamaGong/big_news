import 'package:big_news/state/actions.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LanguageSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, LangViewModel>(
        converter: (Store<AppState> store) => LangViewModel.fromStore(store),
        builder: (_, vm) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AppLocale.values
              .map((e) => LangItem.fromAppLocale(e, vm))
              .toList(),
        ),
      ),
    );
  }
}

class LangItem extends StatelessWidget {
  final AppLocale appLocale;
  final bool isChecked;
  final Function(AppLocale) onPressed;

  LangItem(this.appLocale, this.isChecked, this.onPressed);

  factory LangItem.fromAppLocale(AppLocale appLocale, LangViewModel vm) =>
      LangItem(appLocale, appLocale == vm.currentLocale, vm.setLocale);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            appLocale.tag,
            style: TextStyle(fontSize: 50),
          ),
        ),
        onPressed: isChecked ? null : () => onPressed(appLocale),
      ),
    );
  }
}

@immutable
class LangViewModel {
  final AppLocale currentLocale;
  final Function(AppLocale) setLocale;

  LangViewModel({
    @required this.currentLocale,
    @required this.setLocale,
  });

  factory LangViewModel.fromStore(Store<AppState> store) => LangViewModel(
        currentLocale: store.state.appLocale,
        setLocale: (AppLocale newLocale) {
          store.dispatch(ChangeLocaleAction(newLocale: newLocale));
        },
      );
}
