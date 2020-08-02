import 'package:auto_route/auto_route_annotations.dart';
import 'package:big_news/pages/details_page.dart';
import 'package:big_news/pages/feed_page.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routes: <AutoRoute>[
      MaterialRoute(
        page: FeedPage,
        initial: true,
        children: [
          MaterialRoute(page: DetailScreen, path: '/details'),
          MaterialRoute(page: JobsPage, path: '/jobs'),
          MaterialRoute(page: NewItemsPage, path: '/newItems', initial: true),
        ],
      ),
    ])
class $Router {}
