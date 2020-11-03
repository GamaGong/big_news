import 'package:big_news/api/api.dart';
import 'package:big_news/data/item.dart';
import 'package:built_collection/src/list.dart';
import 'package:built_value/built_value.dart';
import 'package:chopper/src/response.dart';

class TestService extends ItemsService {
  @nullable
  final Response<Item> Function(int) itemProvider;
  @nullable
  final Response<BuiltList<int>> Function() jobsProvider;
  @nullable
  final Response<BuiltList<int>> Function() newStoriesProvider;

  TestService({
    this.itemProvider,
    this.jobsProvider,
    this.newStoriesProvider,
  });

  @override
  Type get definitionType => ItemsService;

  @override
  Future<Response<Item>> getItem(int id) async =>
      itemProvider != null ? itemProvider(id) : Response<Item>(null, null);

  @override
  Future<Response<BuiltList<int>>> getJobsIds() async => jobsProvider != null
      ? jobsProvider()
      : Response<BuiltList<int>>(null, null);

  @override
  Future<Response<BuiltList<int>>> getNewStories() async =>
      newStoriesProvider != null ? newStoriesProvider() : Response(null, null);
}
