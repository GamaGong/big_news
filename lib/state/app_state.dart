import 'package:big_news/data/item.dart';
import 'package:big_news/state/locale.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:flutter/widgets.dart';

@immutable
class AppState {
  final AppLocale appLocale;

  AppState._({
    @required this.appLocale,
  });

  factory AppState.initial({AppLocale appLocale}) => AppState._(
        appLocale: appLocale ?? AppLocale.system,
      );

  AppState copyWith({
    AppLocale appLocale,
  }) =>
      AppState._(
        appLocale: appLocale ?? this.appLocale,
      );

  @override
  int get hashCode => appLocale.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && appLocale == other.appLocale;

  @override
  String toString() => '$AppState{appLocale: $appLocale}';
}

enum LoadingState { loading, loaded, error, none }

@immutable
class FeedScreenState {
  final BuiltList<int> itemsIds;
  final LoadingState loadingState;
  final BuiltMap<int, ItemState> itemsStates;

  FeedScreenState._({
    @required this.itemsIds,
    @required this.loadingState,
    @required this.itemsStates,
  });

  factory FeedScreenState.initial() {
    return FeedScreenState._(
      itemsIds: BuiltList(),
      loadingState: LoadingState.none,
      itemsStates: BuiltMap(),
    );
  }

  FeedScreenState copyWith({
    BuiltList<int> itemsIds,
    LoadingState loadingState,
    BuiltMap<int, ItemState> itemsStates,
  }) =>
      FeedScreenState._(
        itemsIds: itemsIds ?? this.itemsIds,
        loadingState: loadingState ?? this.loadingState,
        itemsStates: itemsStates ?? this.itemsStates,
      );

  @override
  String toString() =>
      '$FeedScreenState{itemsIds:$itemsIds, loadingState:$loadingState, itemsStates:$itemsStates}';

  @override
  int get hashCode =>
      itemsIds.hashCode ^ loadingState.hashCode ^ itemsStates.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedScreenState &&
          itemsIds == other.itemsIds &&
          loadingState == other.loadingState &&
          itemsStates == other.itemsStates;
}

@immutable
class ItemState {
  final int itemId;
  final LoadingState loadingState;
  @nullable
  final Item item;

  ItemState({
    @required this.itemId,
    @required this.loadingState,
    @required this.item,
  });

  factory ItemState.initial(int itemId) => ItemState(
        itemId: itemId,
        loadingState: LoadingState.none,
        item: null,
      );

  ItemState copyWith({
    LoadingState loadingState,
    Item item,
  }) =>
      ItemState(
        itemId: this.itemId,
        loadingState: loadingState ?? this.loadingState,
        item: item ?? this.item,
      );

  @override
  String toString() =>
      '$ItemState{itemId:$itemId, loadingState:$loadingState, item:$item}';

  @override
  int get hashCode => itemId.hashCode ^ loadingState.hashCode ^ item.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemState &&
          itemId == other.itemId &&
          loadingState == other.loadingState &&
          item == other.item;
}
