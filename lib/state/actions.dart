import 'package:big_news/data/item.dart';
import 'package:big_news/state/locale.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';

@immutable
class ChangeLocaleAction {
  final AppLocale newLocale;

  ChangeLocaleAction({
    @required this.newLocale,
  });

  @override
  String toString() => 'ChangeLocaleAction{newLocale: $newLocale}';
}

@immutable
class LoadingItemsIds {
  const LoadingItemsIds();
}

@immutable
class ItemsIdsLoaded {
  final BuiltList<int> itemsIds;

  ItemsIdsLoaded({@required this.itemsIds});
}

@immutable
class FailToLoadItemsIds {
  final Object error;

  FailToLoadItemsIds({@required this.error});
}

@immutable
class ItemIsLoading {
  final int itemId;

  ItemIsLoading({@required this.itemId});
}

@immutable
class FailToLoadItem {
  final int itemId;
  final Object error;

  FailToLoadItem({@required this.itemId, @required this.error});
}

@immutable
class ItemLoaded {
  final Item item;

  ItemLoaded({@required this.item});
}
