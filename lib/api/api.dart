import 'package:big_news/data/item.dart';
import 'package:big_news/data/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper_built_value/chopper_built_value.dart';

// this is necessary for the generated code to find your class
part "api.chopper.dart";

@ChopperApi(baseUrl: 'https://hacker-news.firebaseio.com/v0')
abstract class ItemsService extends ChopperService {
  static ItemsService create([ChopperClient client]) => _$ItemsService(client);

  @Get(path: '/newstories.json')
  Future<Response<BuiltList<int>>> getNewStories();

  @Get(path: '/item/{id}.json')
  Future<Response<Item>> getItem(@Path() int id);

  @Get(path: '/jobs.json')
  Future<Response<BuiltList<int>>> getJobsIds();
}

ChopperClient createClient() =>
    ChopperClient(
      converter: BuiltValueConverter(serializers),
      services: [
        ItemsService.create()
      ],
    );
