import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:big_news/api/api.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/pages/feed_item.dart';
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
  final ScrollController _controller = new ScrollController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGearComposition(_controller),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: ValueKey('bottomNavBar'),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_up),
            label: S.of(context).pageNewStories,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: S.of(context).pageJob,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: S.of(context).maps,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, key: ValueKey('langSettings')),
            label: S.of(context).pageSettings,
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
            initialRoute: '/maps',
          ),
          ExtendedNavigator(
            initialRoute: '/lang_settings',
          ),
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
                controller: context.findAncestorStateOfType<_FeedPageState>()._controller,
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

class RotatedGear extends StatelessWidget {
  RotatedGear(
      {Key key,
      this.controller,
      @required this.gearSize,
      this.isInverted = false})
      : super(key: key);

  final ScrollController controller;
  final double gearSize;
  final bool isInverted;

  get offset => controller.hasClients ? controller.offset : 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
              angle: ((math.pi * offset) / 1024 * (isInverted ? -1 : 1)),
              child: Icon(Icons.settings, size: gearSize, color: Colors.white));
        });
  }
}

class AppBarGearComposition extends StatelessWidget {
  final ScrollController _controller;

  AppBarGearComposition(this._controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 15,
          left: 5,
          child: RotatedGear(
            controller: _controller,
            gearSize: 32,
          ),
        ),
        Positioned(
          top: 10,
          left: 28,
          child: RotatedGear(
            controller: _controller,
            gearSize: 64,
            isInverted: true,
          ),
        ),
      ],
    );
  }
}

