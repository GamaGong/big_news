import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/webfeed.dart';

main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: FeedPage('https://rss.stopgame.ru/rss_all.xml'),
    ),
  ));
}

class FeedPage extends StatefulWidget {
  final String _feedUrl;

  FeedPage(this._feedUrl);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  Widget feedList = LoadingFeed();

  @override
  Widget build(BuildContext context) {
    if (feedList.runtimeType == LoadingFeed) {
      _loadFeedList(widget._feedUrl);
    }
    return feedList;
  }

  _loadFeedList(String feedUrl) async {
    try {
      final client = http.Client();
      final response = await client.get(feedUrl);
      final rawFeed = RssFeed.parse(response.body);

      setState(() {
        feedList = RssFeedList(rawFeed);
      });
    } catch (e) {
      setState(() {
        feedList = ErrorLoadingFeed();
      });
    }
  }
}

class RssFeedList extends StatelessWidget {
  final RssFeed feed;

  RssFeedList(this.feed);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feed.items.length,
      itemBuilder: (context, index) => RssFeedItem(
        feed.items[index],
      ),
    );
  }
}

class RssFeedItem extends StatelessWidget {
  final RssItem _data;

  RssFeedItem(this._data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(_data.link),
      child: Column(
        children: [
          Text(
            _data.title,
          ),
          Html(
            data: _data.description,
            onLinkTap: (url) => _launchUrl(url),
          ),
          CachedNetworkImage(
            imageUrl: _data.enclosure.url,
            placeholder: (context, url) => Container(
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              height: 200,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          FlatButton(
            onPressed: () => _launchUrl(_data.comments),
            child: Text('Комментарии'),
          )
        ],
      ),
    );
  }
}

class LoadingFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorLoadingFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Oh Shit!'),
      ),
    );
  }
}

_launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
