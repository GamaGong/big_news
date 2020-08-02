import 'package:big_news/data/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get id;
  int get delay;
  int get created;
  int get karma;
  String get about;
  BuiltList<int> get submitted;

  User._();
  factory User([void Function(UserBuilder) updates]) = _$User;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(User.serializer, this);
  }

  static User fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(User.serializer, json);
  }

  static Serializer<User> get serializer => _$userSerializer;
}