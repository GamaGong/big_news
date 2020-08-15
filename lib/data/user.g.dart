// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'delay',
      serializers.serialize(object.delay, specifiedType: const FullType(int)),
      'created',
      serializers.serialize(object.created, specifiedType: const FullType(int)),
      'karma',
      serializers.serialize(object.karma, specifiedType: const FullType(int)),
      'about',
      serializers.serialize(object.about,
          specifiedType: const FullType(String)),
      'submitted',
      serializers.serialize(object.submitted,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'delay':
          result.delay = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'karma':
          result.karma = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'about':
          result.about = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'submitted':
          result.submitted.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String id;
  @override
  final int delay;
  @override
  final int created;
  @override
  final int karma;
  @override
  final String about;
  @override
  final BuiltList<int> submitted;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.id,
      this.delay,
      this.created,
      this.karma,
      this.about,
      this.submitted})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (delay == null) {
      throw new BuiltValueNullFieldError('User', 'delay');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('User', 'created');
    }
    if (karma == null) {
      throw new BuiltValueNullFieldError('User', 'karma');
    }
    if (about == null) {
      throw new BuiltValueNullFieldError('User', 'about');
    }
    if (submitted == null) {
      throw new BuiltValueNullFieldError('User', 'submitted');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        delay == other.delay &&
        created == other.created &&
        karma == other.karma &&
        about == other.about &&
        submitted == other.submitted;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, id.hashCode), delay.hashCode), created.hashCode),
                karma.hashCode),
            about.hashCode),
        submitted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('delay', delay)
          ..add('created', created)
          ..add('karma', karma)
          ..add('about', about)
          ..add('submitted', submitted))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _delay;
  int get delay => _$this._delay;
  set delay(int delay) => _$this._delay = delay;

  int _created;
  int get created => _$this._created;
  set created(int created) => _$this._created = created;

  int _karma;
  int get karma => _$this._karma;
  set karma(int karma) => _$this._karma = karma;

  String _about;
  String get about => _$this._about;
  set about(String about) => _$this._about = about;

  ListBuilder<int> _submitted;
  ListBuilder<int> get submitted =>
      _$this._submitted ??= new ListBuilder<int>();
  set submitted(ListBuilder<int> submitted) => _$this._submitted = submitted;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _delay = _$v.delay;
      _created = _$v.created;
      _karma = _$v.karma;
      _about = _$v.about;
      _submitted = _$v.submitted?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    _$User _$result;
    try {
      _$result = _$v ??
          new _$User._(
              id: id,
              delay: delay,
              created: created,
              karma: karma,
              about: about,
              submitted: submitted.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'submitted';
        submitted.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'User', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
