import 'package:big_news/data/item.dart';
import 'package:flutter/services.dart';

const platform = const MethodChannel('notifications');

Future<void> addItemToNotifications(Item item) async {
  await platform.invokeListMethod('addToNotifications', item.title);
}
