import 'package:big_news/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  var currentLocale = Intl.getCurrentLocale();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: S.delegate.supportedLocales.map((e) => LangItem(e, e.toLanguageTag() == currentLocale, setLocale)).toList(),
      ),
    );
  }

  setLocale(Locale newLocale) async {
    await S.load(newLocale);
    setState(() {
      currentLocale = Intl.getCurrentLocale();
    });
  }
}

class LangItem extends StatelessWidget {
  final Locale locale;
  final bool isChecked;
  final Function(Locale) onPressed;

  LangItem(this.locale, this.isChecked, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(locale.toLanguageTag(), style: TextStyle(fontSize: 20),),
      onPressed: isChecked ? null : () => onPressed(locale),
    );
  }
}
