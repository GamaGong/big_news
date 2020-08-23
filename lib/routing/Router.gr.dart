// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../data/item.dart';
import '../pages/details_page.dart';
import '../pages/feed_page.dart';
import '../pages/lang_settings.dart';

class Routes {
  static const String feedPage = '/';
  static const all = <String>{
    feedPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(
      Routes.feedPage,
      page: FeedPage,
      generator: FeedPageRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    FeedPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FeedPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushFeedPage() => push<dynamic>(Routes.feedPage);
}

class FeedPageRoutes {
  static const String detailScreen = '/details';
  static const String jobsPage = '/jobs';
  static const String languageSettings = '/lang_settings';
  static const String newItemsPage = '/newItems';
  static const all = <String>{
    detailScreen,
    jobsPage,
    languageSettings,
    newItemsPage,
  };
}

class FeedPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(FeedPageRoutes.detailScreen, page: DetailScreen),
    RouteDef(FeedPageRoutes.jobsPage, page: JobsPage),
    RouteDef(FeedPageRoutes.languageSettings, page: LanguageSettings),
    RouteDef(FeedPageRoutes.newItemsPage, page: NewItemsPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    DetailScreen: (data) {
      final args = data.getArgs<DetailScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DetailScreen(item: args.item),
        settings: data,
      );
    },
    JobsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => JobsPage(),
        settings: data,
      );
    },
    LanguageSettings: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LanguageSettings(),
        settings: data,
      );
    },
    NewItemsPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NewItemsPage(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension FeedPageRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushDetailScreen({
    @required Item item,
  }) =>
      push<dynamic>(
        FeedPageRoutes.detailScreen,
        arguments: DetailScreenArguments(item: item),
      );

  Future<dynamic> pushJobsPage() => push<dynamic>(FeedPageRoutes.jobsPage);

  Future<dynamic> pushLanguageSettings() =>
      push<dynamic>(FeedPageRoutes.languageSettings);

  Future<dynamic> pushNewItemsPage() =>
      push<dynamic>(FeedPageRoutes.newItemsPage);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// DetailScreen arguments holder class
class DetailScreenArguments {
  final Item item;
  DetailScreenArguments({@required this.item});
}
