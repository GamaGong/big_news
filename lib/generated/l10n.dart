// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `New`
  String get pageNewStories {
    return Intl.message(
      'New',
      name: 'pageNewStories',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get pageJob {
    return Intl.message(
      'Job',
      name: 'pageJob',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get pageSettings {
    return Intl.message(
      'Settings',
      name: 'pageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Something strange happened... 404 I guess`
  String get somethingStrange {
    return Intl.message(
      'Something strange happened... 404 I guess',
      name: 'somethingStrange',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load item`
  String get failedToLoadItem {
    return Intl.message(
      'Failed to load item',
      name: 'failedToLoadItem',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load page`
  String get failedToLoadPage {
    return Intl.message(
      'Failed to load page',
      name: 'failedToLoadPage',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingItem {
    return Intl.message(
      'Loading...',
      name: 'loadingItem',
      desc: '',
      args: [],
    );
  }

  /// `No url. Sorry :(`
  String get noUrlText {
    return Intl.message(
      'No url. Sorry :(',
      name: 'noUrlText',
      desc: '',
      args: [],
    );
  }

  /// `Ops... Something went wrong :({error})`
  String errorTextWithError(Object error) {
    return Intl.message(
      'Ops... Something went wrong :($error)',
      name: 'errorTextWithError',
      desc: '',
      args: [error],
    );
  }

  /// `Maps`
  String get maps {
    return Intl.message(
      'Maps',
      name: 'maps',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}