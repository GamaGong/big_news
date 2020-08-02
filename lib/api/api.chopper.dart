// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ItemsService extends ItemsService {
  _$ItemsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ItemsService;

  @override
  Future<Response<BuiltList<int>>> getNewStories() {
    final $url = 'https://hacker-news.firebaseio.com/v0/newstories.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<int>, int>($request);
  }

  @override
  Future<Response<Item>> getItem(int id) {
    final $url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Item, Item>($request);
  }

  @override
  Future<Response<BuiltList<int>>> getJobsIds() {
    final $url = 'https://hacker-news.firebaseio.com/v0/jobs.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<int>, int>($request);
  }
}
