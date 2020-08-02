import 'package:big_news/data/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'item.g.dart';

abstract class Item implements Built<Item, ItemBuilder> {
  int get id;

  @nullable
  bool get deleted;

  ItemType get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  @nullable
  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  @nullable
  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Item._();

  factory Item([void Function(ItemBuilder) updates]) = _$Item;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Item.serializer, this);
  }

  static Item fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Item.serializer, json).rebuild((b) => b..dead ??= false);
  }

  static Serializer<Item> get serializer => _$itemSerializer;
}

class ItemType extends EnumClass {
  static const ItemType story = _$story;
  static const ItemType job = _$job;
  static const ItemType comment = _$comment;
  static const ItemType poll = _$poll;
  static const ItemType pollopt = _$pollopt;
  
  const ItemType._(String name) : super(name);

  static BuiltSet<ItemType> get values => _$typeValues;
  static ItemType valueOf(String name) => _$typeValueOf(name);
  
  String serialize() {
    return serializers.serializeWith(ItemType.serializer, this);
  }

  static ItemType deserialize(String string) {
    return serializers.deserializeWith(ItemType.serializer, string);
  }

  static Serializer<ItemType> get serializer => _$itemTypeSerializer;
}
