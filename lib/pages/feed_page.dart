import 'package:auto_route/auto_route.dart';
import 'package:big_news/api/api.dart';
import 'package:big_news/data/item.dart';
import 'package:big_news/generated/l10n.dart';
import 'package:big_news/routing/Router.gr.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final itemService = createClient().getService<ItemsService>();

Future<Item> getItem(int itemId, BuildContext context) async {
  final response = await itemService.getItem(itemId);

  if (response.isSuccessful) {
    return response.body;
  } else {
    throw Exception(S.of(context).failedToLoadItem);
  }
}

Future<BuiltList<int>> getNewStories(BuildContext context) async {
  final response = await itemService.getNewStories();

  if (response.isSuccessful) {
    // successful request
    return response.body;
  } else {
    // error from server
    throw S.of(context).failedToLoadPage;
  }
}

Future<BuiltList<int>> getJobs(BuildContext context) async {
  final response = await itemService.getJobsIds();

  if (response.isSuccessful) {
    // successful request
    return response.body;
  } else {
    // error from server
    throw S.of(context).failedToLoadPage;
  }
}

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

class NewItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BuiltList<int>>(
      future: getNewStories(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return (snapshot.hasError)
                ? Center(child: Text("${snapshot.error}"))
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemWidget(
                      snapshot.data[index],
                      key: Key(snapshot.data[index].toString()),
                    ),
                  );
          default:
            return Text(S.of(context).somethingStrange);
        }
      },
    );
  }
}

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BuiltList<int>>(
      future: getJobs(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return (snapshot.hasError)
                ? Center(child: Text("${snapshot.error}"))
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ItemWidget(
                      snapshot.data[index],
                      key: Key(snapshot.data[index].toString()),
                    ),
                  );
          default:
            return Text(S.of(context).somethingStrange);
        }
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  final int id;

  ItemWidget(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getItem(id, context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return LoadingItem();
          case ConnectionState.done:
            return (snapshot.hasError)
                ? ErrorItem(snapshot.error)
                : LoadedItem(snapshot.data);
          default:
            return ErrorItem(snapshot.connectionState);
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
