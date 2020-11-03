import 'package:auto_route/auto_route.dart';
import 'package:big_news/api/api.dart';
import 'package:big_news/channel/notification.dart';
import 'package:big_news/data/item.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/pages/feed_page.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/middleware.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  factory ItemViewModel.fromStore(
    Store<FeedScreenState> store,
    int itemId,
    ItemsService itemsService,
  ) {
    final itemState = store.state.itemsStates[itemId];
    if (itemState == null || itemState.loadingState == LoadingState.none)
      store.dispatch(loadItem(itemId, itemsService));
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
          ItemViewModel.fromStore(store, id, itemService),
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

  LoadedItem(this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.url != null && item.url.isNotEmpty)
      return ExpansionTile(
        key: Key(item.id.toString()),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(item.title),
            ),
            IconButton(
              icon: Icon(Icons.add_to_home_screen_outlined),
              onPressed: () async => addItemToNotifications(item),
            )
          ],
        ),
        children: <Widget>[
          SizedBox(
            height: 200,
            child: WebView(
              initialUrl: item.url,
              javascriptMode: JavascriptMode.unrestricted,
              gestureRecognizers: Set()
                ..add(Factory<VerticalDragGestureRecognizer>(
                  () => VerticalDragGestureRecognizer()..onUpdate = (_) {},
                )),
            ),
          ),
        ],
      );
    else
      return ListTile(
        title: Text(item.title),
        key: Key(item.id.toString()),
      );
  }
}
