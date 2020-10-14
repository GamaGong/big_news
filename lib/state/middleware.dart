import 'package:big_news/api/api.dart';
import 'package:big_news/state/actions.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/locale.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<FeedScreenState> loadItemsIds(Future<Response<BuiltList<int>>> Function() loadingBlock) =>
    (Store<FeedScreenState> store) async {
      store.dispatch(LoadingItemsIds());
      final response = await loadingBlock();

      if (response.isSuccessful) {
        store.dispatch(ItemsIdsLoaded(itemsIds: response.body));
      } else {
        store.dispatch(FailToLoadItemsIds(error: null));
      }
    };

ThunkAction<FeedScreenState> loadItem(int itemId, ItemsService service) {
  return (Store<FeedScreenState> store) async {
    var item = store.state.itemsStates[itemId]?.item;
    if (item != null) {
      store.dispatch(ItemLoaded(item: item));
    } else {
      store.dispatch(ItemIsLoading(itemId: itemId));
      final response = await service.getItem(itemId);

      if (response.isSuccessful) {
        store.dispatch(ItemLoaded(item: response.body));
      } else {
        store.dispatch(FailToLoadItem(itemId: itemId, error: null));
      }
    }
  };
}

ThunkAction<AppState> changeLocale(AppLocale newAppLocale) {
  return (Store<AppState> store) async {
    store.dispatch(ChangeLocaleAction(newLocale: newAppLocale));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString((AppLocale).toString(), newAppLocale.tag);
  };
}