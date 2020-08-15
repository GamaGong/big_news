// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ItemType _$story = const ItemType._('story');
const ItemType _$job = const ItemType._('job');
const ItemType _$comment = const ItemType._('comment');
const ItemType _$poll = const ItemType._('poll');
const ItemType _$pollopt = const ItemType._('pollopt');

ItemType _$typeValueOf(String name) {
  switch (name) {
    case 'story':
      return _$story;
    case 'job':
      return _$job;
    case 'comment':
      return _$comment;
    case 'poll':
      return _$poll;
    case 'pollopt':
      return _$pollopt;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<ItemType> _$typeValues = new BuiltSet<ItemType>(const <ItemType>[
  _$story,
  _$job,
  _$comment,
  _$poll,
  _$pollopt,
]);

Serializer<Item> _$itemSerializer = new _$ItemSerializer();
Serializer<ItemType> _$itemTypeSerializer = new _$ItemTypeSerializer();

class _$ItemSerializer implements StructuredSerializer<Item> {
  @override
  final Iterable<Type> types = const [Item, _$Item];
  @override
  final String wireName = 'Item';

  @override
  Iterable<Object> serialize(Serializers serializers, Item object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(ItemType)),
      'by',
      serializers.serialize(object.by, specifiedType: const FullType(String)),
      'time',
      serializers.serialize(object.time, specifiedType: const FullType(int)),
    ];
    if (object.deleted != null) {
      result
        ..add('deleted')
        ..add(serializers.serialize(object.deleted,
            specifiedType: const FullType(bool)));
    }
    if (object.text != null) {
      result
        ..add('text')
        ..add(serializers.serialize(object.text,
            specifiedType: const FullType(String)));
    }
    if (object.dead != null) {
      result
        ..add('dead')
        ..add(serializers.serialize(object.dead,
            specifiedType: const FullType(bool)));
    }
    if (object.parent != null) {
      result
        ..add('parent')
        ..add(serializers.serialize(object.parent,
            specifiedType: const FullType(int)));
    }
    if (object.poll != null) {
      result
        ..add('poll')
        ..add(serializers.serialize(object.poll,
            specifiedType: const FullType(int)));
    }
    if (object.kids != null) {
      result
        ..add('kids')
        ..add(serializers.serialize(object.kids,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    if (object.url != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.url,
            specifiedType: const FullType(String)));
    }
    if (object.score != null) {
      result
        ..add('score')
        ..add(serializers.serialize(object.score,
            specifiedType: const FullType(int)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.parts != null) {
      result
        ..add('parts')
        ..add(serializers.serialize(object.parts,
            specifiedType:
                const FullType(BuiltList, const [const FullType(int)])));
    }
    if (object.descendants != null) {
      result
        ..add('descendants')
        ..add(serializers.serialize(object.descendants,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Item deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'deleted':
          result.deleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(ItemType)) as ItemType;
          break;
        case 'by':
          result.by = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'time':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'text':
          result.text = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dead':
          result.dead = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'parent':
          result.parent = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'poll':
          result.poll = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'kids':
          result.kids.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'parts':
          result.parts.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))
              as BuiltList<Object>);
          break;
        case 'descendants':
          result.descendants = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$ItemTypeSerializer implements PrimitiveSerializer<ItemType> {
  @override
  final Iterable<Type> types = const <Type>[ItemType];
  @override
  final String wireName = 'ItemType';

  @override
  Object serialize(Serializers serializers, ItemType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  ItemType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ItemType.valueOf(serialized as String);
}

class _$Item extends Item {
  @override
  final int id;
  @override
  final bool deleted;
  @override
  final ItemType type;
  @override
  final String by;
  @override
  final int time;
  @override
  final String text;
  @override
  final bool dead;
  @override
  final int parent;
  @override
  final int poll;
  @override
  final BuiltList<int> kids;
  @override
  final String url;
  @override
  final int score;
  @override
  final String title;
  @override
  final BuiltList<int> parts;
  @override
  final int descendants;

  factory _$Item([void Function(ItemBuilder) updates]) =>
      (new ItemBuilder()..update(updates)).build();

  _$Item._(
      {this.id,
      this.deleted,
      this.type,
      this.by,
      this.time,
      this.text,
      this.dead,
      this.parent,
      this.poll,
      this.kids,
      this.url,
      this.score,
      this.title,
      this.parts,
      this.descendants})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Item', 'id');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('Item', 'type');
    }
    if (by == null) {
      throw new BuiltValueNullFieldError('Item', 'by');
    }
    if (time == null) {
      throw new BuiltValueNullFieldError('Item', 'time');
    }
  }

  @override
  Item rebuild(void Function(ItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ItemBuilder toBuilder() => new ItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Item &&
        id == other.id &&
        deleted == other.deleted &&
        type == other.type &&
        by == other.by &&
        time == other.time &&
        text == other.text &&
        dead == other.dead &&
        parent == other.parent &&
        poll == other.poll &&
        kids == other.kids &&
        url == other.url &&
        score == other.score &&
        title == other.title &&
        parts == other.parts &&
        descendants == other.descendants;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc($jc(0, id.hashCode),
                                                            deleted.hashCode),
                                                        type.hashCode),
                                                    by.hashCode),
                                                time.hashCode),
                                            text.hashCode),
                                        dead.hashCode),
                                    parent.hashCode),
                                poll.hashCode),
                            kids.hashCode),
                        url.hashCode),
                    score.hashCode),
                title.hashCode),
            parts.hashCode),
        descendants.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Item')
          ..add('id', id)
          ..add('deleted', deleted)
          ..add('type', type)
          ..add('by', by)
          ..add('time', time)
          ..add('text', text)
          ..add('dead', dead)
          ..add('parent', parent)
          ..add('poll', poll)
          ..add('kids', kids)
          ..add('url', url)
          ..add('score', score)
          ..add('title', title)
          ..add('parts', parts)
          ..add('descendants', descendants))
        .toString();
  }
}

class ItemBuilder implements Builder<Item, ItemBuilder> {
  _$Item _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  bool _deleted;
  bool get deleted => _$this._deleted;
  set deleted(bool deleted) => _$this._deleted = deleted;

  ItemType _type;
  ItemType get type => _$this._type;
  set type(ItemType type) => _$this._type = type;

  String _by;
  String get by => _$this._by;
  set by(String by) => _$this._by = by;

  int _time;
  int get time => _$this._time;
  set time(int time) => _$this._time = time;

  String _text;
  String get text => _$this._text;
  set text(String text) => _$this._text = text;

  bool _dead;
  bool get dead => _$this._dead;
  set dead(bool dead) => _$this._dead = dead;

  int _parent;
  int get parent => _$this._parent;
  set parent(int parent) => _$this._parent = parent;

  int _poll;
  int get poll => _$this._poll;
  set poll(int poll) => _$this._poll = poll;

  ListBuilder<int> _kids;
  ListBuilder<int> get kids => _$this._kids ??= new ListBuilder<int>();
  set kids(ListBuilder<int> kids) => _$this._kids = kids;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _score;
  int get score => _$this._score;
  set score(int score) => _$this._score = score;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  ListBuilder<int> _parts;
  ListBuilder<int> get parts => _$this._parts ??= new ListBuilder<int>();
  set parts(ListBuilder<int> parts) => _$this._parts = parts;

  int _descendants;
  int get descendants => _$this._descendants;
  set descendants(int descendants) => _$this._descendants = descendants;

  ItemBuilder();

  ItemBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _deleted = _$v.deleted;
      _type = _$v.type;
      _by = _$v.by;
      _time = _$v.time;
      _text = _$v.text;
      _dead = _$v.dead;
      _parent = _$v.parent;
      _poll = _$v.poll;
      _kids = _$v.kids?.toBuilder();
      _url = _$v.url;
      _score = _$v.score;
      _title = _$v.title;
      _parts = _$v.parts?.toBuilder();
      _descendants = _$v.descendants;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Item other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Item;
  }

  @override
  void update(void Function(ItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Item build() {
    _$Item _$result;
    try {
      _$result = _$v ??
          new _$Item._(
              id: id,
              deleted: deleted,
              type: type,
              by: by,
              time: time,
              text: text,
              dead: dead,
              parent: parent,
              poll: poll,
              kids: _kids?.build(),
              url: url,
              score: score,
              title: title,
              parts: _parts?.build(),
              descendants: descendants);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'kids';
        _kids?.build();

        _$failedField = 'parts';
        _parts?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Item', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
