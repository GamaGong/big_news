import 'package:big_news/state/actions.dart';
import 'package:big_news/state/app_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> appReducer = combineReducers([
  TypedReducer<AppState, ChangeLocaleAction>(_changeLocale),
]);

final _changeLocale = (AppState state, ChangeLocaleAction action) =>
    state.copyWith(appLocale: action.newLocale);

final Reducer<FeedScreenState> feedScreenReducer = combineReducers([
  TypedReducer<FeedScreenState, LoadingItemsIds>(_loadingItemsIds),
  TypedReducer<FeedScreenState, ItemsIdsLoaded>(_itemsIdsLoaded),
  TypedReducer<FeedScreenState, FailToLoadItemsIds>(_newStoriesNotLoaded),
  TypedReducer<FeedScreenState, ItemIsLoading>(_itemIsLoading),
  TypedReducer<FeedScreenState, FailToLoadItem>(_failToLoadItem),
  TypedReducer<FeedScreenState, ItemLoaded>(_itemLoaded),
]);

final _loadingItemsIds = (FeedScreenState state, LoadingItemsIds action) =>
    state.copyWith(loadingState: LoadingState.loading);

final _itemsIdsLoaded =
    (FeedScreenState state, ItemsIdsLoaded action) => state.copyWith(
          itemsIds: action.itemsIds,
          loadingState: LoadingState.loaded,
          itemsStates: (MapBuilder<int, ItemState>()
                ..addIterable(
                  action.itemsIds,
                  value: (id) => ItemState.initial(id),
                ))
              .build(),
        );

final _newStoriesNotLoaded =
    (FeedScreenState state, FailToLoadItemsIds action) =>
        state.copyWith(loadingState: LoadingState.error);

final FeedScreenState Function(FeedScreenState state, ItemIsLoading action)
    _itemIsLoading = (FeedScreenState state, ItemIsLoading action) {
  final itemId = action.itemId;
  final itemLoadingState =
      (state.itemsStates[itemId] ?? ItemState.initial(itemId))
          .copyWith(loadingState: LoadingState.loading);
  final itemStatesBuilder = state.itemsStates.toBuilder();
  itemStatesBuilder[itemId] = itemLoadingState;

  return state.copyWith(itemsStates: itemStatesBuilder.build());
};

final FeedScreenState Function(FeedScreenState state, FailToLoadItem action)
    _failToLoadItem = (FeedScreenState state, FailToLoadItem action) {
  final itemId = action.itemId;
  final itemErrorState =
      (state.itemsStates[itemId] ?? ItemState.initial(itemId))
          .copyWith(loadingState: LoadingState.error);
  final itemStatesBuilder = state.itemsStates.toBuilder();
  itemStatesBuilder[itemId] = itemErrorState;

  return state.copyWith(itemsStates: itemStatesBuilder.build());
};

final FeedScreenState Function(FeedScreenState state, ItemLoaded action)
    _itemLoaded = (FeedScreenState state, ItemLoaded action) {
  final itemId = action.item.id;
  final itemLoadedState =
      (state.itemsStates[itemId] ?? ItemState.initial(itemId))
          .copyWith(loadingState: LoadingState.loaded, item: action.item);
  final itemStatesBuilder = state.itemsStates.toBuilder();
  itemStatesBuilder[itemId] = itemLoadedState;

  return state.copyWith(itemsStates: itemStatesBuilder.build());
};
