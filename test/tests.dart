import 'dart:convert';

import 'package:big_news/data/item.dart';
import 'package:big_news/pages/feed_item.dart';
import 'package:big_news/state/app_state.dart';
import 'package:big_news/state/reducers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'api/service.dart';

void main() {
  group(
    'Test for Item model',
    () {
      test('Item deserialization', () {
        final jsonString = '''{
  "by" : "dhouston",
  "descendants" : 71,
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}''';

        final json = jsonDecode(jsonString);
        final item = Item.fromJson(json);
        final expected = Item((b) => b
          ..by = 'dhouston'
          ..descendants = 71
          ..id = 8863
          ..kids.update((b) => b
            ..addAll([
              8952,
              9224,
              8917,
              8884,
              8887,
              8943,
              8869,
              8958,
              9005,
              9671,
              8940,
              9067,
              8908,
              9055,
              8865,
              8881,
              8872,
              8873,
              8955,
              10403,
              8903,
              8928,
              9125,
              8998,
              8901,
              8902,
              8907,
              8894,
              8878,
              8870,
              8980,
              8934,
              8876
            ]))
          ..score = 111
          ..time = 1175714200
          ..title = "My YC app: Dropbox - Throw away your USB drive"
          ..type = ItemType.story
          ..dead = false
          ..url = "http://www.getdropbox.com/u/2/screencast.html");
        expect(item, expected);
      });

      test('Item serialization', () {
        final jsonString = '''{
  "by" : "dhouston",
  "descendants" : 71,
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}''';
        final expected = jsonDecode(jsonString);
        final actual = Item((b) => b
          ..by = 'dhouston'
          ..descendants = 71
          ..id = 8863
          ..kids.update((b) => b
            ..addAll([
              8952,
              9224,
              8917,
              8884,
              8887,
              8943,
              8869,
              8958,
              9005,
              9671,
              8940,
              9067,
              8908,
              9055,
              8865,
              8881,
              8872,
              8873,
              8955,
              10403,
              8903,
              8928,
              9125,
              8998,
              8901,
              8902,
              8907,
              8894,
              8878,
              8870,
              8980,
              8934,
              8876
            ]))
          ..score = 111
          ..time = 1175714200
          ..title = "My YC app: Dropbox - Throw away your USB drive"
          ..type = ItemType.story
          ..url = "http://www.getdropbox.com/u/2/screencast.html");
        expect(actual.toJson(), expected);
      });
    },
  );

  group('ItemViewModel', () {
    test(
      'ItemViewModel initial state test',
      () async {
        const id = 1;
        final store = Store<FeedScreenState>(
          feedScreenReducer,
          initialState: FeedScreenState.initial(),
        );
        final service = TestService();
        final viewModel = ItemViewModel.fromStore(store, id, service);
        expect(viewModel.loadingState, LoadingState.none);
        expect(viewModel.itemId, id);
      },
    );

    test(
      'ItemViewModel item loading/error state test',
      () async {
        const id = 1;
        final itemState = ItemState(
            itemId: id, loadingState: LoadingState.loading, item: null);
        final store = Store<FeedScreenState>(
          feedScreenReducer,
          initialState: FeedScreenState.initial(
            itemsStates: BuiltMap.of({id: itemState}),
          ),
        );
        final service = TestService();
        final viewModel = ItemViewModel.fromStore(store, id, service);
        expect(viewModel.loadingState, itemState.loadingState);
        expect(viewModel.itemId, id);
      },
    );

    test(
      'ItemViewModel item loaded state test',
      () async {
        const id = 1;
        final item = Item((b) => b
          ..id = id
          ..type = ItemType.job
          ..by = 'by'
          ..time = 1);
        final itemState = ItemState(
          itemId: id,
          loadingState: LoadingState.loaded,
          item: item,
        );
        final store = Store<FeedScreenState>(
          feedScreenReducer,
          initialState: FeedScreenState.initial(
            itemsStates: BuiltMap.of({id: itemState}),
          ),
        );
        final service = TestService();
        final viewModel = ItemViewModel.fromStore(store, id, service);
        expect(viewModel.loadingState, itemState.loadingState);
        expect(viewModel.itemId, id);
        expect(viewModel.item, item);
      },
    );
  });

  group('Tests for LoadedItem', () {
    testWidgets(
      'Loaded widget with item without url',
      (WidgetTester tester) async {
        const id = 1;
        const title = 'title';
        final key = Key(id.toString());
        final item = Item((b) => b
          ..id = id
          ..title = title
          ..type = ItemType.job
          ..by = 'by'
          ..time = 1);
        await tester
            .pumpWidget(MaterialApp(home: Scaffold(body: LoadedItem(item))));
        expect(find.byType(ListTile), findsOneWidget);
        expect(find.text('title'), findsOneWidget);
        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'Loaded widget with item with url',
      (WidgetTester tester) async {
        const id = 1;
        const title = 'title';
        const url = 'url';
        final key = Key(id.toString());
        final item = Item((b) => b
          ..id = id
          ..title = title
          ..type = ItemType.job
          ..by = 'by'
          ..time = 1
          ..url = url);
        await tester
            .pumpWidget(MaterialApp(home: Scaffold(body: LoadedItem(item))));
        expect(find.byType(ExpansionTile), findsOneWidget);
        expect(find.text('title'), findsOneWidget);
        expect(find.byKey(key), findsOneWidget);
        expect(find.byIcon(Icons.add_to_home_screen_outlined), findsOneWidget);
      },
    );

    testWidgets(
      'Loaded widget with item with url',
      (WidgetTester tester) async {
        const id = 1;
        const title = 'title';
        const url = 'url';
        final item = Item((b) => b
          ..id = id
          ..title = title
          ..type = ItemType.job
          ..by = 'by'
          ..time = 1
          ..url = url);
        await tester
            .pumpWidget(MaterialApp(home: Scaffold(body: LoadedItem(item))));
        expect(find.byType(WebView), findsNothing);
        await tester.tap(find.byType(ExpansionTile));
        await tester.pump();
        expect(find.byType(WebView), findsOneWidget);
      },
    );
  });
}
