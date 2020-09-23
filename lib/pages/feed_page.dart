import 'package:auto_route/auto_route.dart';
import 'package:big_news/api/api.dart';
import 'package:big_news/data/item.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/routing/Router.gr.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/middleware.dart';
import 'package:big_news/state/reducers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final itemService = createClient().getService<ItemsService>();

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_up),
            title: Text(S.of(context).pageNewStories),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            title: Text(S.of(context).pageJob),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(S.of(context).pageSettings),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          ExtendedNavigator(
            initialRoute: '/newItems',
          ),
          ExtendedNavigator(
            initialRoute: '/jobs',
          ),
          ExtendedNavigator(
            initialRoute: '/lang_settings',
          )
        ],
      ),
    );
  }

  _onTap(int index) => setState(() => _selectedIndex = index);
}

@immutable
class FeedScreenViewModel {
  final LoadingState loadingState;
  final BuiltList<int> itemsIds;

  FeedScreenViewModel({
    @required this.loadingState,
    @required this.itemsIds,
  });

  factory FeedScreenViewModel.fromStore(Store<FeedScreenState> store,
      Future<Response<BuiltList<int>>> Function() loadingBlock) {
    if (store.state.loadingState == LoadingState.none)
      store.dispatch(loadItemsIds(loadingBlock));
    return FeedScreenViewModel(
      loadingState: store.state.loadingState,
      itemsIds: store.state.itemsIds,
    );
  }
}

class NewItemsPage extends StatelessWidget {
  final store = Store<FeedScreenState>(
    feedScreenReducer,
    initialState: FeedScreenState.initial(),
    middleware: [thunkMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<FeedScreenState>(
      store: store,
      child: StoreConnector<FeedScreenState, FeedScreenViewModel>(
        converter: (Store<FeedScreenState> store) =>
            FeedScreenViewModel.fromStore(store, itemService.getNewStories),
        builder: (_, vm) {
          switch (vm.loadingState) {
            case LoadingState.loaded:
              return ListView.builder(
                itemCount: vm.itemsIds.length,
                itemBuilder: (BuildContext context, int index) => ItemWidget(
                  vm.itemsIds[index],
                  key: Key(vm.itemsIds[index].toString()),
                ),
              );
            case LoadingState.error:
              return Center(child: Text(S.of(context).failedToLoadPage));
            case LoadingState.loading:
            case LoadingState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Text(S.of(context).somethingStrange);
          }
        },
      ),
    );
  }
}

class JobsPage extends StatelessWidget {
  final store = Store<FeedScreenState>(
    feedScreenReducer,
    initialState: FeedScreenState.initial(),
    middleware: [thunkMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<FeedScreenState>(
      store: store,
      child: StoreConnector<FeedScreenState, FeedScreenViewModel>(
        converter: (Store<FeedScreenState> store) =>
            FeedScreenViewModel.fromStore(store, itemService.getJobsIds),
        builder: (_, vm) {
          switch (vm.loadingState) {
            case LoadingState.loaded:
              return ListView.builder(
                itemCount: vm.itemsIds.length,
                itemBuilder: (BuildContext context, int index) => ItemWidget(
                  vm.itemsIds[index],
                  key: Key(vm.itemsIds[index].toString()),
                ),
              );
            case LoadingState.error:
              return Center(child: Text(S.of(context).failedToLoadPage));
            case LoadingState.loading:
            case LoadingState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Text(S.of(context).somethingStrange);
          }
        },
      ),
    );
  }
}

@immutable
class ItemViewModel {
  final int itemId;
  final LoadingState loadingState;
  final Item item;

  ItemViewModel({
    @required this.itemId,
    @required this.loadingState,
    @required this.item,
  });

  factory ItemViewModel.fromStore(Store<FeedScreenState> store, int itemId) {
    final itemState = store.state.itemsStates[itemId];
    if (itemState == null || itemState.loadingState == LoadingState.none)
      store.dispatch(loadItem(itemId, itemService));
    return ItemViewModel(
      loadingState: itemState?.loadingState ?? LoadingState.none,
      itemId: itemId,
      item: itemState?.item,
    );
  }
}

class ItemWidget extends StatelessWidget {
  final int id;

  ItemWidget(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<FeedScreenState, ItemViewModel>(
      converter: (Store<FeedScreenState> store) =>
          ItemViewModel.fromStore(store, id),
      builder: (context, vm) {
        switch (vm.loadingState) {
          case LoadingState.none:
          case LoadingState.loading:
            return LoadingItem();
          case LoadingState.loaded:
            return LoadedItem(vm.item);
          case LoadingState.error:
            return ErrorItem(S
                .of(context)
                .errorTextWithError(S.of(context).failedToLoadItem));
          default:
            return Text(S.of(context).somethingStrange);
        }
      },
    );
  }
}

class LoadingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularProgressIndicator(),
      title: Text(S.of(context).loadingItem),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final Object error;

  ErrorItem(this.error);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(S.of(context).errorTextWithError(error)),
    );
  }
}

class LoadedItem extends StatelessWidget {
  final Item item;

  LoadedItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      onTap: () {
        ExtendedNavigator.of(context).pushDetailScreen(item: item);
      },
    );
  }
}
