// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_isar.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetFilterIsarCollection on Isar {
  IsarCollection<FilterIsar> get filterIsars => getCollection();
}

const FilterIsarSchema = CollectionSchema(
  name: 'FilterIsar',
  schema:
      '{"name":"FilterIsar","idName":"id","properties":[{"name":"enable","type":"Bool"},{"name":"expr","type":"Bool"},{"name":"filter","type":"String"},{"name":"name","type":"String"},{"name":"to","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'enable': 0, 'expr': 1, 'filter': 2, 'name': 3, 'to': 4},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _filterIsarGetId,
  setId: _filterIsarSetId,
  getLinks: _filterIsarGetLinks,
  attachLinks: _filterIsarAttachLinks,
  serializeNative: _filterIsarSerializeNative,
  deserializeNative: _filterIsarDeserializeNative,
  deserializePropNative: _filterIsarDeserializePropNative,
  serializeWeb: _filterIsarSerializeWeb,
  deserializeWeb: _filterIsarDeserializeWeb,
  deserializePropWeb: _filterIsarDeserializePropWeb,
  version: 3,
);

int? _filterIsarGetId(FilterIsar object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _filterIsarSetId(FilterIsar object, int id) {
  object.id = id;
}

List<IsarLinkBase> _filterIsarGetLinks(FilterIsar object) {
  return [];
}

void _filterIsarSerializeNative(
    IsarCollection<FilterIsar> collection,
    IsarRawObject rawObj,
    FilterIsar object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.enable;
  final _enable = value0;
  final value1 = object.expr;
  final _expr = value1;
  final value2 = object.filter;
  final _filter = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_filter.length) as int;
  final value3 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_name.length) as int;
  final value4 = object.to;
  final _to = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_to.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBool(offsets[0], _enable);
  writer.writeBool(offsets[1], _expr);
  writer.writeBytes(offsets[2], _filter);
  writer.writeBytes(offsets[3], _name);
  writer.writeBytes(offsets[4], _to);
}

FilterIsar _filterIsarDeserializeNative(IsarCollection<FilterIsar> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = FilterIsar(
    enable: reader.readBool(offsets[0]),
    expr: reader.readBool(offsets[1]),
    filter: reader.readString(offsets[2]),
    name: reader.readString(offsets[3]),
    to: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _filterIsarDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _filterIsarSerializeWeb(
    IsarCollection<FilterIsar> collection, FilterIsar object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'enable', object.enable);
  IsarNative.jsObjectSet(jsObj, 'expr', object.expr);
  IsarNative.jsObjectSet(jsObj, 'filter', object.filter);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'to', object.to);
  return jsObj;
}

FilterIsar _filterIsarDeserializeWeb(
    IsarCollection<FilterIsar> collection, dynamic jsObj) {
  final object = FilterIsar(
    enable: IsarNative.jsObjectGet(jsObj, 'enable') ?? false,
    expr: IsarNative.jsObjectGet(jsObj, 'expr') ?? false,
    filter: IsarNative.jsObjectGet(jsObj, 'filter') ?? '',
    name: IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    to: IsarNative.jsObjectGet(jsObj, 'to') ?? '',
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _filterIsarDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'enable':
      return (IsarNative.jsObjectGet(jsObj, 'enable') ?? false) as P;
    case 'expr':
      return (IsarNative.jsObjectGet(jsObj, 'expr') ?? false) as P;
    case 'filter':
      return (IsarNative.jsObjectGet(jsObj, 'filter') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'to':
      return (IsarNative.jsObjectGet(jsObj, 'to') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _filterIsarAttachLinks(IsarCollection col, int id, FilterIsar object) {}

extension FilterIsarQueryWhereSort
    on QueryBuilder<FilterIsar, FilterIsar, QWhere> {
  QueryBuilder<FilterIsar, FilterIsar, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension FilterIsarQueryWhere
    on QueryBuilder<FilterIsar, FilterIsar, QWhereClause> {
  QueryBuilder<FilterIsar, FilterIsar, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension FilterIsarQueryFilter
    on QueryBuilder<FilterIsar, FilterIsar, QFilterCondition> {
  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> enableEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'enable',
      value: value,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> exprEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'expr',
      value: value,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'filter',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'filter',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> filterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'filter',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'to',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'to',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterFilterCondition> toMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'to',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension FilterIsarQueryLinks
    on QueryBuilder<FilterIsar, FilterIsar, QFilterCondition> {}

extension FilterIsarQueryWhereSortBy
    on QueryBuilder<FilterIsar, FilterIsar, QSortBy> {
  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByEnable() {
    return addSortByInternal('enable', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByEnableDesc() {
    return addSortByInternal('enable', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByExpr() {
    return addSortByInternal('expr', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByExprDesc() {
    return addSortByInternal('expr', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByFilter() {
    return addSortByInternal('filter', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByFilterDesc() {
    return addSortByInternal('filter', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByTo() {
    return addSortByInternal('to', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> sortByToDesc() {
    return addSortByInternal('to', Sort.desc);
  }
}

extension FilterIsarQueryWhereSortThenBy
    on QueryBuilder<FilterIsar, FilterIsar, QSortThenBy> {
  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByEnable() {
    return addSortByInternal('enable', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByEnableDesc() {
    return addSortByInternal('enable', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByExpr() {
    return addSortByInternal('expr', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByExprDesc() {
    return addSortByInternal('expr', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByFilter() {
    return addSortByInternal('filter', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByFilterDesc() {
    return addSortByInternal('filter', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByTo() {
    return addSortByInternal('to', Sort.asc);
  }

  QueryBuilder<FilterIsar, FilterIsar, QAfterSortBy> thenByToDesc() {
    return addSortByInternal('to', Sort.desc);
  }
}

extension FilterIsarQueryWhereDistinct
    on QueryBuilder<FilterIsar, FilterIsar, QDistinct> {
  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctByEnable() {
    return addDistinctByInternal('enable');
  }

  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctByExpr() {
    return addDistinctByInternal('expr');
  }

  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctByFilter(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('filter', caseSensitive: caseSensitive);
  }

  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<FilterIsar, FilterIsar, QDistinct> distinctByTo(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('to', caseSensitive: caseSensitive);
  }
}

extension FilterIsarQueryProperty
    on QueryBuilder<FilterIsar, FilterIsar, QQueryProperty> {
  QueryBuilder<FilterIsar, bool, QQueryOperations> enableProperty() {
    return addPropertyNameInternal('enable');
  }

  QueryBuilder<FilterIsar, bool, QQueryOperations> exprProperty() {
    return addPropertyNameInternal('expr');
  }

  QueryBuilder<FilterIsar, String, QQueryOperations> filterProperty() {
    return addPropertyNameInternal('filter');
  }

  QueryBuilder<FilterIsar, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<FilterIsar, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<FilterIsar, String, QQueryOperations> toProperty() {
    return addPropertyNameInternal('to');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetWordCacheCollection on Isar {
  IsarCollection<WordCache> get wordCaches => getCollection();
}

const WordCacheSchema = CollectionSchema(
  name: 'WordCache',
  schema:
      '{"name":"WordCache","idName":"id","properties":[{"name":"height","type":"Double"},{"name":"width","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'height': 0, 'width': 1},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _wordCacheGetId,
  setId: _wordCacheSetId,
  getLinks: _wordCacheGetLinks,
  attachLinks: _wordCacheAttachLinks,
  serializeNative: _wordCacheSerializeNative,
  deserializeNative: _wordCacheDeserializeNative,
  deserializePropNative: _wordCacheDeserializePropNative,
  serializeWeb: _wordCacheSerializeWeb,
  deserializeWeb: _wordCacheDeserializeWeb,
  deserializePropWeb: _wordCacheDeserializePropWeb,
  version: 3,
);

int? _wordCacheGetId(WordCache object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _wordCacheSetId(WordCache object, int id) {
  object.id = id;
}

List<IsarLinkBase> _wordCacheGetLinks(WordCache object) {
  return [];
}

void _wordCacheSerializeNative(
    IsarCollection<WordCache> collection,
    IsarRawObject rawObj,
    WordCache object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.height;
  final _height = value0;
  final value1 = object.width;
  final _width = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDouble(offsets[0], _height);
  writer.writeDouble(offsets[1], _width);
}

WordCache _wordCacheDeserializeNative(IsarCollection<WordCache> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = WordCache(
    height: reader.readDouble(offsets[0]),
    id: id,
    width: reader.readDouble(offsets[1]),
  );
  return object;
}

P _wordCacheDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _wordCacheSerializeWeb(
    IsarCollection<WordCache> collection, WordCache object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'height', object.height);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'width', object.width);
  return jsObj;
}

WordCache _wordCacheDeserializeWeb(
    IsarCollection<WordCache> collection, dynamic jsObj) {
  final object = WordCache(
    height: IsarNative.jsObjectGet(jsObj, 'height') ?? double.negativeInfinity,
    id: IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity,
    width: IsarNative.jsObjectGet(jsObj, 'width') ?? double.negativeInfinity,
  );
  return object;
}

P _wordCacheDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'height':
      return (IsarNative.jsObjectGet(jsObj, 'height') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'width':
      return (IsarNative.jsObjectGet(jsObj, 'width') ?? double.negativeInfinity)
          as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _wordCacheAttachLinks(IsarCollection col, int id, WordCache object) {}

extension WordCacheQueryWhereSort
    on QueryBuilder<WordCache, WordCache, QWhere> {
  QueryBuilder<WordCache, WordCache, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension WordCacheQueryWhere
    on QueryBuilder<WordCache, WordCache, QWhereClause> {
  QueryBuilder<WordCache, WordCache, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<WordCache, WordCache, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<WordCache, WordCache, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<WordCache, WordCache, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension WordCacheQueryFilter
    on QueryBuilder<WordCache, WordCache, QFilterCondition> {
  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> heightGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'height',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> heightLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'height',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> heightBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'height',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> widthGreaterThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'width',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> widthLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'width',
      value: value,
    ));
  }

  QueryBuilder<WordCache, WordCache, QAfterFilterCondition> widthBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'width',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension WordCacheQueryLinks
    on QueryBuilder<WordCache, WordCache, QFilterCondition> {}

extension WordCacheQueryWhereSortBy
    on QueryBuilder<WordCache, WordCache, QSortBy> {
  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortByHeight() {
    return addSortByInternal('height', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortByHeightDesc() {
    return addSortByInternal('height', Sort.desc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortByWidth() {
    return addSortByInternal('width', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> sortByWidthDesc() {
    return addSortByInternal('width', Sort.desc);
  }
}

extension WordCacheQueryWhereSortThenBy
    on QueryBuilder<WordCache, WordCache, QSortThenBy> {
  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenByHeight() {
    return addSortByInternal('height', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenByHeightDesc() {
    return addSortByInternal('height', Sort.desc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenByWidth() {
    return addSortByInternal('width', Sort.asc);
  }

  QueryBuilder<WordCache, WordCache, QAfterSortBy> thenByWidthDesc() {
    return addSortByInternal('width', Sort.desc);
  }
}

extension WordCacheQueryWhereDistinct
    on QueryBuilder<WordCache, WordCache, QDistinct> {
  QueryBuilder<WordCache, WordCache, QDistinct> distinctByHeight() {
    return addDistinctByInternal('height');
  }

  QueryBuilder<WordCache, WordCache, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<WordCache, WordCache, QDistinct> distinctByWidth() {
    return addDistinctByInternal('width');
  }
}

extension WordCacheQueryProperty
    on QueryBuilder<WordCache, WordCache, QQueryProperty> {
  QueryBuilder<WordCache, double, QQueryOperations> heightProperty() {
    return addPropertyNameInternal('height');
  }

  QueryBuilder<WordCache, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<WordCache, double, QQueryOperations> widthProperty() {
    return addPropertyNameInternal('width');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetContentsIsarCollection on Isar {
  IsarCollection<ContentsIsar> get contentsIsars => getCollection();
}

const ContentsIsarSchema = CollectionSchema(
  name: 'ContentsIsar',
  schema:
      '{"name":"ContentsIsar","idName":"id","properties":[{"name":"fullPageIdx","type":"Long"},{"name":"height","type":"Double"},{"name":"idx","type":"Long"},{"name":"pageIdx","type":"Long"},{"name":"text","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'fullPageIdx': 0,
    'height': 1,
    'idx': 2,
    'pageIdx': 3,
    'text': 4
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _contentsIsarGetId,
  setId: _contentsIsarSetId,
  getLinks: _contentsIsarGetLinks,
  attachLinks: _contentsIsarAttachLinks,
  serializeNative: _contentsIsarSerializeNative,
  deserializeNative: _contentsIsarDeserializeNative,
  deserializePropNative: _contentsIsarDeserializePropNative,
  serializeWeb: _contentsIsarSerializeWeb,
  deserializeWeb: _contentsIsarDeserializeWeb,
  deserializePropWeb: _contentsIsarDeserializePropWeb,
  version: 3,
);

int? _contentsIsarGetId(ContentsIsar object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _contentsIsarSetId(ContentsIsar object, int id) {
  object.id = id;
}

List<IsarLinkBase> _contentsIsarGetLinks(ContentsIsar object) {
  return [];
}

void _contentsIsarSerializeNative(
    IsarCollection<ContentsIsar> collection,
    IsarRawObject rawObj,
    ContentsIsar object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.fullPageIdx;
  final _fullPageIdx = value0;
  final value1 = object.height;
  final _height = value1;
  final value2 = object.idx;
  final _idx = value2;
  final value3 = object.pageIdx;
  final _pageIdx = value3;
  final value4 = object.text;
  final _text = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_text.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _fullPageIdx);
  writer.writeDouble(offsets[1], _height);
  writer.writeLong(offsets[2], _idx);
  writer.writeLong(offsets[3], _pageIdx);
  writer.writeBytes(offsets[4], _text);
}

ContentsIsar _contentsIsarDeserializeNative(
    IsarCollection<ContentsIsar> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ContentsIsar(
    fullPageIdx: reader.readLong(offsets[0]),
    height: reader.readDouble(offsets[1]),
    idx: reader.readLong(offsets[2]),
    pageIdx: reader.readLong(offsets[3]),
    text: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _contentsIsarDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _contentsIsarSerializeWeb(
    IsarCollection<ContentsIsar> collection, ContentsIsar object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'fullPageIdx', object.fullPageIdx);
  IsarNative.jsObjectSet(jsObj, 'height', object.height);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'idx', object.idx);
  IsarNative.jsObjectSet(jsObj, 'pageIdx', object.pageIdx);
  IsarNative.jsObjectSet(jsObj, 'text', object.text);
  return jsObj;
}

ContentsIsar _contentsIsarDeserializeWeb(
    IsarCollection<ContentsIsar> collection, dynamic jsObj) {
  final object = ContentsIsar(
    fullPageIdx:
        IsarNative.jsObjectGet(jsObj, 'fullPageIdx') ?? double.negativeInfinity,
    height: IsarNative.jsObjectGet(jsObj, 'height') ?? double.negativeInfinity,
    idx: IsarNative.jsObjectGet(jsObj, 'idx') ?? double.negativeInfinity,
    pageIdx:
        IsarNative.jsObjectGet(jsObj, 'pageIdx') ?? double.negativeInfinity,
    text: IsarNative.jsObjectGet(jsObj, 'text') ?? '',
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _contentsIsarDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'fullPageIdx':
      return (IsarNative.jsObjectGet(jsObj, 'fullPageIdx') ??
          double.negativeInfinity) as P;
    case 'height':
      return (IsarNative.jsObjectGet(jsObj, 'height') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'idx':
      return (IsarNative.jsObjectGet(jsObj, 'idx') ?? double.negativeInfinity)
          as P;
    case 'pageIdx':
      return (IsarNative.jsObjectGet(jsObj, 'pageIdx') ??
          double.negativeInfinity) as P;
    case 'text':
      return (IsarNative.jsObjectGet(jsObj, 'text') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _contentsIsarAttachLinks(
    IsarCollection col, int id, ContentsIsar object) {}

extension ContentsIsarQueryWhereSort
    on QueryBuilder<ContentsIsar, ContentsIsar, QWhere> {
  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension ContentsIsarQueryWhere
    on QueryBuilder<ContentsIsar, ContentsIsar, QWhereClause> {
  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension ContentsIsarQueryFilter
    on QueryBuilder<ContentsIsar, ContentsIsar, QFilterCondition> {
  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      fullPageIdxEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fullPageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      fullPageIdxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fullPageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      fullPageIdxLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fullPageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      fullPageIdxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fullPageIdx',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      heightGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'height',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      heightLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'height',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> heightBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'height',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idxEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'idx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      idxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'idx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idxLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'idx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> idxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'idx',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      pageIdxEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'pageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      pageIdxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'pageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      pageIdxLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'pageIdx',
      value: value,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      pageIdxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'pageIdx',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'text',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'text',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'text',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ContentsIsarQueryLinks
    on QueryBuilder<ContentsIsar, ContentsIsar, QFilterCondition> {}

extension ContentsIsarQueryWhereSortBy
    on QueryBuilder<ContentsIsar, ContentsIsar, QSortBy> {
  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByFullPageIdx() {
    return addSortByInternal('fullPageIdx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy>
      sortByFullPageIdxDesc() {
    return addSortByInternal('fullPageIdx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByHeight() {
    return addSortByInternal('height', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByHeightDesc() {
    return addSortByInternal('height', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByIdx() {
    return addSortByInternal('idx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByIdxDesc() {
    return addSortByInternal('idx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByPageIdx() {
    return addSortByInternal('pageIdx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByPageIdxDesc() {
    return addSortByInternal('pageIdx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> sortByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }
}

extension ContentsIsarQueryWhereSortThenBy
    on QueryBuilder<ContentsIsar, ContentsIsar, QSortThenBy> {
  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByFullPageIdx() {
    return addSortByInternal('fullPageIdx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy>
      thenByFullPageIdxDesc() {
    return addSortByInternal('fullPageIdx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByHeight() {
    return addSortByInternal('height', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByHeightDesc() {
    return addSortByInternal('height', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByIdx() {
    return addSortByInternal('idx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByIdxDesc() {
    return addSortByInternal('idx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByPageIdx() {
    return addSortByInternal('pageIdx', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByPageIdxDesc() {
    return addSortByInternal('pageIdx', Sort.desc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByText() {
    return addSortByInternal('text', Sort.asc);
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QAfterSortBy> thenByTextDesc() {
    return addSortByInternal('text', Sort.desc);
  }
}

extension ContentsIsarQueryWhereDistinct
    on QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> {
  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctByFullPageIdx() {
    return addDistinctByInternal('fullPageIdx');
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctByHeight() {
    return addDistinctByInternal('height');
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctByIdx() {
    return addDistinctByInternal('idx');
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctByPageIdx() {
    return addDistinctByInternal('pageIdx');
  }

  QueryBuilder<ContentsIsar, ContentsIsar, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('text', caseSensitive: caseSensitive);
  }
}

extension ContentsIsarQueryProperty
    on QueryBuilder<ContentsIsar, ContentsIsar, QQueryProperty> {
  QueryBuilder<ContentsIsar, int, QQueryOperations> fullPageIdxProperty() {
    return addPropertyNameInternal('fullPageIdx');
  }

  QueryBuilder<ContentsIsar, double, QQueryOperations> heightProperty() {
    return addPropertyNameInternal('height');
  }

  QueryBuilder<ContentsIsar, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ContentsIsar, int, QQueryOperations> idxProperty() {
    return addPropertyNameInternal('idx');
  }

  QueryBuilder<ContentsIsar, int, QQueryOperations> pageIdxProperty() {
    return addPropertyNameInternal('pageIdx');
  }

  QueryBuilder<ContentsIsar, String, QQueryOperations> textProperty() {
    return addPropertyNameInternal('text');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetSettingIsarCollection on Isar {
  IsarCollection<SettingIsar> get settingIsars => getCollection();
}

const SettingIsarSchema = CollectionSchema(
  name: 'SettingIsar',
  schema:
      '{"name":"SettingIsar","idName":"id","properties":[{"name":"adPosition","type":"Long"},{"name":"audioduck","type":"Bool"},{"name":"audiosession","type":"Bool"},{"name":"backgroundColor","type":"Long"},{"name":"bgFilter","type":"Long"},{"name":"bgIdx","type":"Long"},{"name":"customFont","type":"String"},{"name":"enablescroll","type":"Bool"},{"name":"fontColor","type":"Long"},{"name":"fontFamily","type":"String"},{"name":"fontHeight","type":"Double"},{"name":"fontSize","type":"Double"},{"name":"fontWeight","type":"Long"},{"name":"fullScreenType","type":"Long"},{"name":"groupcnt","type":"Long"},{"name":"headsetbutton","type":"Bool"},{"name":"last24Ad","type":"Long"},{"name":"lastDevVersion","type":"String"},{"name":"letterSpacing","type":"Double"},{"name":"paddingBottom","type":"Double"},{"name":"paddingLeft","type":"Double"},{"name":"paddingRight","type":"Double"},{"name":"paddingTop","type":"Double"},{"name":"pitch","type":"Double"},{"name":"speechRate","type":"Double"},{"name":"theme","type":"String"},{"name":"touchLayout","type":"Long"},{"name":"useClipboard","type":"Bool"},{"name":"volume","type":"Double"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'adPosition': 0,
    'audioduck': 1,
    'audiosession': 2,
    'backgroundColor': 3,
    'bgFilter': 4,
    'bgIdx': 5,
    'customFont': 6,
    'enablescroll': 7,
    'fontColor': 8,
    'fontFamily': 9,
    'fontHeight': 10,
    'fontSize': 11,
    'fontWeight': 12,
    'fullScreenType': 13,
    'groupcnt': 14,
    'headsetbutton': 15,
    'last24Ad': 16,
    'lastDevVersion': 17,
    'letterSpacing': 18,
    'paddingBottom': 19,
    'paddingLeft': 20,
    'paddingRight': 21,
    'paddingTop': 22,
    'pitch': 23,
    'speechRate': 24,
    'theme': 25,
    'touchLayout': 26,
    'useClipboard': 27,
    'volume': 28
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _settingIsarGetId,
  setId: _settingIsarSetId,
  getLinks: _settingIsarGetLinks,
  attachLinks: _settingIsarAttachLinks,
  serializeNative: _settingIsarSerializeNative,
  deserializeNative: _settingIsarDeserializeNative,
  deserializePropNative: _settingIsarDeserializePropNative,
  serializeWeb: _settingIsarSerializeWeb,
  deserializeWeb: _settingIsarDeserializeWeb,
  deserializePropWeb: _settingIsarDeserializePropWeb,
  version: 3,
);

int? _settingIsarGetId(SettingIsar object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _settingIsarSetId(SettingIsar object, int id) {
  object.id = id;
}

List<IsarLinkBase> _settingIsarGetLinks(SettingIsar object) {
  return [];
}

void _settingIsarSerializeNative(
    IsarCollection<SettingIsar> collection,
    IsarRawObject rawObj,
    SettingIsar object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.adPosition;
  final _adPosition = value0;
  final value1 = object.audioduck;
  final _audioduck = value1;
  final value2 = object.audiosession;
  final _audiosession = value2;
  final value3 = object.backgroundColor;
  final _backgroundColor = value3;
  final value4 = object.bgFilter;
  final _bgFilter = value4;
  final value5 = object.bgIdx;
  final _bgIdx = value5;
  final value6 = object.customFont;
  IsarUint8List? _customFont;
  if (value6 != null) {
    _customFont = IsarBinaryWriter.utf8Encoder.convert(value6);
  }
  dynamicSize += (_customFont?.length ?? 0) as int;
  final value7 = object.enablescroll;
  final _enablescroll = value7;
  final value8 = object.fontColor;
  final _fontColor = value8;
  final value9 = object.fontFamily;
  final _fontFamily = IsarBinaryWriter.utf8Encoder.convert(value9);
  dynamicSize += (_fontFamily.length) as int;
  final value10 = object.fontHeight;
  final _fontHeight = value10;
  final value11 = object.fontSize;
  final _fontSize = value11;
  final value12 = object.fontWeight;
  final _fontWeight = value12;
  final value13 = object.fullScreenType;
  final _fullScreenType = value13;
  final value14 = object.groupcnt;
  final _groupcnt = value14;
  final value15 = object.headsetbutton;
  final _headsetbutton = value15;
  final value16 = object.last24Ad;
  final _last24Ad = value16;
  final value17 = object.lastDevVersion;
  final _lastDevVersion = IsarBinaryWriter.utf8Encoder.convert(value17);
  dynamicSize += (_lastDevVersion.length) as int;
  final value18 = object.letterSpacing;
  final _letterSpacing = value18;
  final value19 = object.paddingBottom;
  final _paddingBottom = value19;
  final value20 = object.paddingLeft;
  final _paddingLeft = value20;
  final value21 = object.paddingRight;
  final _paddingRight = value21;
  final value22 = object.paddingTop;
  final _paddingTop = value22;
  final value23 = object.pitch;
  final _pitch = value23;
  final value24 = object.speechRate;
  final _speechRate = value24;
  final value25 = object.theme;
  final _theme = IsarBinaryWriter.utf8Encoder.convert(value25);
  dynamicSize += (_theme.length) as int;
  final value26 = object.touchLayout;
  final _touchLayout = value26;
  final value27 = object.useClipboard;
  final _useClipboard = value27;
  final value28 = object.volume;
  final _volume = value28;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _adPosition);
  writer.writeBool(offsets[1], _audioduck);
  writer.writeBool(offsets[2], _audiosession);
  writer.writeLong(offsets[3], _backgroundColor);
  writer.writeLong(offsets[4], _bgFilter);
  writer.writeLong(offsets[5], _bgIdx);
  writer.writeBytes(offsets[6], _customFont);
  writer.writeBool(offsets[7], _enablescroll);
  writer.writeLong(offsets[8], _fontColor);
  writer.writeBytes(offsets[9], _fontFamily);
  writer.writeDouble(offsets[10], _fontHeight);
  writer.writeDouble(offsets[11], _fontSize);
  writer.writeLong(offsets[12], _fontWeight);
  writer.writeLong(offsets[13], _fullScreenType);
  writer.writeLong(offsets[14], _groupcnt);
  writer.writeBool(offsets[15], _headsetbutton);
  writer.writeDateTime(offsets[16], _last24Ad);
  writer.writeBytes(offsets[17], _lastDevVersion);
  writer.writeDouble(offsets[18], _letterSpacing);
  writer.writeDouble(offsets[19], _paddingBottom);
  writer.writeDouble(offsets[20], _paddingLeft);
  writer.writeDouble(offsets[21], _paddingRight);
  writer.writeDouble(offsets[22], _paddingTop);
  writer.writeDouble(offsets[23], _pitch);
  writer.writeDouble(offsets[24], _speechRate);
  writer.writeBytes(offsets[25], _theme);
  writer.writeLong(offsets[26], _touchLayout);
  writer.writeBool(offsets[27], _useClipboard);
  writer.writeDouble(offsets[28], _volume);
}

SettingIsar _settingIsarDeserializeNative(
    IsarCollection<SettingIsar> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = SettingIsar(
    adPosition: reader.readLong(offsets[0]),
    audioduck: reader.readBool(offsets[1]),
    audiosession: reader.readBool(offsets[2]),
    backgroundColor: reader.readLong(offsets[3]),
    bgFilter: reader.readLong(offsets[4]),
    bgIdx: reader.readLong(offsets[5]),
    customFont: reader.readStringOrNull(offsets[6]),
    enablescroll: reader.readBool(offsets[7]),
    fontColor: reader.readLong(offsets[8]),
    fontFamily: reader.readString(offsets[9]),
    fontHeight: reader.readDouble(offsets[10]),
    fontSize: reader.readDouble(offsets[11]),
    fontWeight: reader.readLong(offsets[12]),
    fullScreenType: reader.readLong(offsets[13]),
    groupcnt: reader.readLong(offsets[14]),
    headsetbutton: reader.readBool(offsets[15]),
    lastDevVersion: reader.readString(offsets[17]),
    letterSpacing: reader.readDouble(offsets[18]),
    paddingBottom: reader.readDouble(offsets[19]),
    paddingLeft: reader.readDouble(offsets[20]),
    paddingRight: reader.readDouble(offsets[21]),
    paddingTop: reader.readDouble(offsets[22]),
    pitch: reader.readDouble(offsets[23]),
    speechRate: reader.readDouble(offsets[24]),
    theme: reader.readString(offsets[25]),
    touchLayout: reader.readLong(offsets[26]),
    useClipboard: reader.readBool(offsets[27]),
    volume: reader.readDouble(offsets[28]),
  );
  object.id = id;
  object.last24Ad = reader.readDateTime(offsets[16]);
  return object;
}

P _settingIsarDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readDouble(offset)) as P;
    case 20:
      return (reader.readDouble(offset)) as P;
    case 21:
      return (reader.readDouble(offset)) as P;
    case 22:
      return (reader.readDouble(offset)) as P;
    case 23:
      return (reader.readDouble(offset)) as P;
    case 24:
      return (reader.readDouble(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readLong(offset)) as P;
    case 27:
      return (reader.readBool(offset)) as P;
    case 28:
      return (reader.readDouble(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _settingIsarSerializeWeb(
    IsarCollection<SettingIsar> collection, SettingIsar object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'adPosition', object.adPosition);
  IsarNative.jsObjectSet(jsObj, 'audioduck', object.audioduck);
  IsarNative.jsObjectSet(jsObj, 'audiosession', object.audiosession);
  IsarNative.jsObjectSet(jsObj, 'backgroundColor', object.backgroundColor);
  IsarNative.jsObjectSet(jsObj, 'bgFilter', object.bgFilter);
  IsarNative.jsObjectSet(jsObj, 'bgIdx', object.bgIdx);
  IsarNative.jsObjectSet(jsObj, 'customFont', object.customFont);
  IsarNative.jsObjectSet(jsObj, 'enablescroll', object.enablescroll);
  IsarNative.jsObjectSet(jsObj, 'fontColor', object.fontColor);
  IsarNative.jsObjectSet(jsObj, 'fontFamily', object.fontFamily);
  IsarNative.jsObjectSet(jsObj, 'fontHeight', object.fontHeight);
  IsarNative.jsObjectSet(jsObj, 'fontSize', object.fontSize);
  IsarNative.jsObjectSet(jsObj, 'fontWeight', object.fontWeight);
  IsarNative.jsObjectSet(jsObj, 'fullScreenType', object.fullScreenType);
  IsarNative.jsObjectSet(jsObj, 'groupcnt', object.groupcnt);
  IsarNative.jsObjectSet(jsObj, 'headsetbutton', object.headsetbutton);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(
      jsObj, 'last24Ad', object.last24Ad.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'lastDevVersion', object.lastDevVersion);
  IsarNative.jsObjectSet(jsObj, 'letterSpacing', object.letterSpacing);
  IsarNative.jsObjectSet(jsObj, 'paddingBottom', object.paddingBottom);
  IsarNative.jsObjectSet(jsObj, 'paddingLeft', object.paddingLeft);
  IsarNative.jsObjectSet(jsObj, 'paddingRight', object.paddingRight);
  IsarNative.jsObjectSet(jsObj, 'paddingTop', object.paddingTop);
  IsarNative.jsObjectSet(jsObj, 'pitch', object.pitch);
  IsarNative.jsObjectSet(jsObj, 'speechRate', object.speechRate);
  IsarNative.jsObjectSet(jsObj, 'theme', object.theme);
  IsarNative.jsObjectSet(jsObj, 'touchLayout', object.touchLayout);
  IsarNative.jsObjectSet(jsObj, 'useClipboard', object.useClipboard);
  IsarNative.jsObjectSet(jsObj, 'volume', object.volume);
  return jsObj;
}

SettingIsar _settingIsarDeserializeWeb(
    IsarCollection<SettingIsar> collection, dynamic jsObj) {
  final object = SettingIsar(
    adPosition:
        IsarNative.jsObjectGet(jsObj, 'adPosition') ?? double.negativeInfinity,
    audioduck: IsarNative.jsObjectGet(jsObj, 'audioduck') ?? false,
    audiosession: IsarNative.jsObjectGet(jsObj, 'audiosession') ?? false,
    backgroundColor: IsarNative.jsObjectGet(jsObj, 'backgroundColor') ??
        double.negativeInfinity,
    bgFilter:
        IsarNative.jsObjectGet(jsObj, 'bgFilter') ?? double.negativeInfinity,
    bgIdx: IsarNative.jsObjectGet(jsObj, 'bgIdx') ?? double.negativeInfinity,
    customFont: IsarNative.jsObjectGet(jsObj, 'customFont'),
    enablescroll: IsarNative.jsObjectGet(jsObj, 'enablescroll') ?? false,
    fontColor:
        IsarNative.jsObjectGet(jsObj, 'fontColor') ?? double.negativeInfinity,
    fontFamily: IsarNative.jsObjectGet(jsObj, 'fontFamily') ?? '',
    fontHeight:
        IsarNative.jsObjectGet(jsObj, 'fontHeight') ?? double.negativeInfinity,
    fontSize:
        IsarNative.jsObjectGet(jsObj, 'fontSize') ?? double.negativeInfinity,
    fontWeight:
        IsarNative.jsObjectGet(jsObj, 'fontWeight') ?? double.negativeInfinity,
    fullScreenType: IsarNative.jsObjectGet(jsObj, 'fullScreenType') ??
        double.negativeInfinity,
    groupcnt:
        IsarNative.jsObjectGet(jsObj, 'groupcnt') ?? double.negativeInfinity,
    headsetbutton: IsarNative.jsObjectGet(jsObj, 'headsetbutton') ?? false,
    lastDevVersion: IsarNative.jsObjectGet(jsObj, 'lastDevVersion') ?? '',
    letterSpacing: IsarNative.jsObjectGet(jsObj, 'letterSpacing') ??
        double.negativeInfinity,
    paddingBottom: IsarNative.jsObjectGet(jsObj, 'paddingBottom') ??
        double.negativeInfinity,
    paddingLeft:
        IsarNative.jsObjectGet(jsObj, 'paddingLeft') ?? double.negativeInfinity,
    paddingRight: IsarNative.jsObjectGet(jsObj, 'paddingRight') ??
        double.negativeInfinity,
    paddingTop:
        IsarNative.jsObjectGet(jsObj, 'paddingTop') ?? double.negativeInfinity,
    pitch: IsarNative.jsObjectGet(jsObj, 'pitch') ?? double.negativeInfinity,
    speechRate:
        IsarNative.jsObjectGet(jsObj, 'speechRate') ?? double.negativeInfinity,
    theme: IsarNative.jsObjectGet(jsObj, 'theme') ?? '',
    touchLayout:
        IsarNative.jsObjectGet(jsObj, 'touchLayout') ?? double.negativeInfinity,
    useClipboard: IsarNative.jsObjectGet(jsObj, 'useClipboard') ?? false,
    volume: IsarNative.jsObjectGet(jsObj, 'volume') ?? double.negativeInfinity,
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.last24Ad = IsarNative.jsObjectGet(jsObj, 'last24Ad') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'last24Ad'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  return object;
}

P _settingIsarDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'adPosition':
      return (IsarNative.jsObjectGet(jsObj, 'adPosition') ??
          double.negativeInfinity) as P;
    case 'audioduck':
      return (IsarNative.jsObjectGet(jsObj, 'audioduck') ?? false) as P;
    case 'audiosession':
      return (IsarNative.jsObjectGet(jsObj, 'audiosession') ?? false) as P;
    case 'backgroundColor':
      return (IsarNative.jsObjectGet(jsObj, 'backgroundColor') ??
          double.negativeInfinity) as P;
    case 'bgFilter':
      return (IsarNative.jsObjectGet(jsObj, 'bgFilter') ??
          double.negativeInfinity) as P;
    case 'bgIdx':
      return (IsarNative.jsObjectGet(jsObj, 'bgIdx') ?? double.negativeInfinity)
          as P;
    case 'customFont':
      return (IsarNative.jsObjectGet(jsObj, 'customFont')) as P;
    case 'enablescroll':
      return (IsarNative.jsObjectGet(jsObj, 'enablescroll') ?? false) as P;
    case 'fontColor':
      return (IsarNative.jsObjectGet(jsObj, 'fontColor') ??
          double.negativeInfinity) as P;
    case 'fontFamily':
      return (IsarNative.jsObjectGet(jsObj, 'fontFamily') ?? '') as P;
    case 'fontHeight':
      return (IsarNative.jsObjectGet(jsObj, 'fontHeight') ??
          double.negativeInfinity) as P;
    case 'fontSize':
      return (IsarNative.jsObjectGet(jsObj, 'fontSize') ??
          double.negativeInfinity) as P;
    case 'fontWeight':
      return (IsarNative.jsObjectGet(jsObj, 'fontWeight') ??
          double.negativeInfinity) as P;
    case 'fullScreenType':
      return (IsarNative.jsObjectGet(jsObj, 'fullScreenType') ??
          double.negativeInfinity) as P;
    case 'groupcnt':
      return (IsarNative.jsObjectGet(jsObj, 'groupcnt') ??
          double.negativeInfinity) as P;
    case 'headsetbutton':
      return (IsarNative.jsObjectGet(jsObj, 'headsetbutton') ?? false) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'last24Ad':
      return (IsarNative.jsObjectGet(jsObj, 'last24Ad') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'last24Ad'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'lastDevVersion':
      return (IsarNative.jsObjectGet(jsObj, 'lastDevVersion') ?? '') as P;
    case 'letterSpacing':
      return (IsarNative.jsObjectGet(jsObj, 'letterSpacing') ??
          double.negativeInfinity) as P;
    case 'paddingBottom':
      return (IsarNative.jsObjectGet(jsObj, 'paddingBottom') ??
          double.negativeInfinity) as P;
    case 'paddingLeft':
      return (IsarNative.jsObjectGet(jsObj, 'paddingLeft') ??
          double.negativeInfinity) as P;
    case 'paddingRight':
      return (IsarNative.jsObjectGet(jsObj, 'paddingRight') ??
          double.negativeInfinity) as P;
    case 'paddingTop':
      return (IsarNative.jsObjectGet(jsObj, 'paddingTop') ??
          double.negativeInfinity) as P;
    case 'pitch':
      return (IsarNative.jsObjectGet(jsObj, 'pitch') ?? double.negativeInfinity)
          as P;
    case 'speechRate':
      return (IsarNative.jsObjectGet(jsObj, 'speechRate') ??
          double.negativeInfinity) as P;
    case 'theme':
      return (IsarNative.jsObjectGet(jsObj, 'theme') ?? '') as P;
    case 'touchLayout':
      return (IsarNative.jsObjectGet(jsObj, 'touchLayout') ??
          double.negativeInfinity) as P;
    case 'useClipboard':
      return (IsarNative.jsObjectGet(jsObj, 'useClipboard') ?? false) as P;
    case 'volume':
      return (IsarNative.jsObjectGet(jsObj, 'volume') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _settingIsarAttachLinks(IsarCollection col, int id, SettingIsar object) {}

extension SettingIsarQueryWhereSort
    on QueryBuilder<SettingIsar, SettingIsar, QWhere> {
  QueryBuilder<SettingIsar, SettingIsar, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension SettingIsarQueryWhere
    on QueryBuilder<SettingIsar, SettingIsar, QWhereClause> {
  QueryBuilder<SettingIsar, SettingIsar, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension SettingIsarQueryFilter
    on QueryBuilder<SettingIsar, SettingIsar, QFilterCondition> {
  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      adPositionEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'adPosition',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      adPositionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'adPosition',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      adPositionLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'adPosition',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      adPositionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'adPosition',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      audioduckEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'audioduck',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      audiosessionEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'audiosession',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      backgroundColorEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'backgroundColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      backgroundColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'backgroundColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      backgroundColorLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'backgroundColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      backgroundColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'backgroundColor',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> bgFilterEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'bgFilter',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      bgFilterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'bgFilter',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      bgFilterLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'bgFilter',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> bgFilterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'bgFilter',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> bgIdxEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'bgIdx',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      bgIdxGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'bgIdx',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> bgIdxLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'bgIdx',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> bgIdxBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'bgIdx',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'customFont',
      value: null,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontGreaterThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontLessThan(
    String? value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'customFont',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'customFont',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      customFontMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'customFont',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      enablescrollEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'enablescroll',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontColorEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fontColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fontColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontColorLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fontColor',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fontColor',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fontFamily',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fontFamily',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontFamilyMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fontFamily',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontHeightGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'fontHeight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontHeightLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'fontHeight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontHeightBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fontHeight',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontSizeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'fontSize',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontSizeLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'fontSize',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> fontSizeBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fontSize',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontWeightEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fontWeight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontWeightGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fontWeight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontWeightLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fontWeight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fontWeightBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fontWeight',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fullScreenTypeEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fullScreenType',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fullScreenTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fullScreenType',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fullScreenTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fullScreenType',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      fullScreenTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fullScreenType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> groupcntEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'groupcnt',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      groupcntGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'groupcnt',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      groupcntLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'groupcnt',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> groupcntBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'groupcnt',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      headsetbuttonEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'headsetbutton',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> last24AdEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'last24Ad',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      last24AdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'last24Ad',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      last24AdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'last24Ad',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> last24AdBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'last24Ad',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'lastDevVersion',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'lastDevVersion',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      lastDevVersionMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'lastDevVersion',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      letterSpacingGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'letterSpacing',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      letterSpacingLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'letterSpacing',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      letterSpacingBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'letterSpacing',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingBottomGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'paddingBottom',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingBottomLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'paddingBottom',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingBottomBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'paddingBottom',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingLeftGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'paddingLeft',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingLeftLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'paddingLeft',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingLeftBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'paddingLeft',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingRightGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'paddingRight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingRightLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'paddingRight',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingRightBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'paddingRight',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingTopGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'paddingTop',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingTopLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'paddingTop',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      paddingTopBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'paddingTop',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      pitchGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'pitch',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> pitchLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'pitch',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> pitchBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'pitch',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      speechRateGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'speechRate',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      speechRateLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'speechRate',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      speechRateBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'speechRate',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      themeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'theme',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'theme',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> themeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'theme',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      touchLayoutEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'touchLayout',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      touchLayoutGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'touchLayout',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      touchLayoutLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'touchLayout',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      touchLayoutBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'touchLayout',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      useClipboardEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'useClipboard',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition>
      volumeGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'volume',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> volumeLessThan(
      double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'volume',
      value: value,
    ));
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterFilterCondition> volumeBetween(
      double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'volume',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }
}

extension SettingIsarQueryLinks
    on QueryBuilder<SettingIsar, SettingIsar, QFilterCondition> {}

extension SettingIsarQueryWhereSortBy
    on QueryBuilder<SettingIsar, SettingIsar, QSortBy> {
  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByAdPosition() {
    return addSortByInternal('adPosition', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByAdPositionDesc() {
    return addSortByInternal('adPosition', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByAudioduck() {
    return addSortByInternal('audioduck', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByAudioduckDesc() {
    return addSortByInternal('audioduck', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByAudiosession() {
    return addSortByInternal('audiosession', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByAudiosessionDesc() {
    return addSortByInternal('audiosession', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByBackgroundColor() {
    return addSortByInternal('backgroundColor', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByBackgroundColorDesc() {
    return addSortByInternal('backgroundColor', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByBgFilter() {
    return addSortByInternal('bgFilter', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByBgFilterDesc() {
    return addSortByInternal('bgFilter', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByBgIdx() {
    return addSortByInternal('bgIdx', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByBgIdxDesc() {
    return addSortByInternal('bgIdx', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByCustomFont() {
    return addSortByInternal('customFont', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByCustomFontDesc() {
    return addSortByInternal('customFont', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByEnablescroll() {
    return addSortByInternal('enablescroll', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByEnablescrollDesc() {
    return addSortByInternal('enablescroll', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontColor() {
    return addSortByInternal('fontColor', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontColorDesc() {
    return addSortByInternal('fontColor', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontFamily() {
    return addSortByInternal('fontFamily', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontFamilyDesc() {
    return addSortByInternal('fontFamily', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontHeight() {
    return addSortByInternal('fontHeight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontHeightDesc() {
    return addSortByInternal('fontHeight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontSize() {
    return addSortByInternal('fontSize', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontSizeDesc() {
    return addSortByInternal('fontSize', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontWeight() {
    return addSortByInternal('fontWeight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFontWeightDesc() {
    return addSortByInternal('fontWeight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByFullScreenType() {
    return addSortByInternal('fullScreenType', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByFullScreenTypeDesc() {
    return addSortByInternal('fullScreenType', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByGroupcnt() {
    return addSortByInternal('groupcnt', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByGroupcntDesc() {
    return addSortByInternal('groupcnt', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByHeadsetbutton() {
    return addSortByInternal('headsetbutton', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByHeadsetbuttonDesc() {
    return addSortByInternal('headsetbutton', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByLast24Ad() {
    return addSortByInternal('last24Ad', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByLast24AdDesc() {
    return addSortByInternal('last24Ad', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByLastDevVersion() {
    return addSortByInternal('lastDevVersion', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByLastDevVersionDesc() {
    return addSortByInternal('lastDevVersion', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByLetterSpacing() {
    return addSortByInternal('letterSpacing', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByLetterSpacingDesc() {
    return addSortByInternal('letterSpacing', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingBottom() {
    return addSortByInternal('paddingBottom', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByPaddingBottomDesc() {
    return addSortByInternal('paddingBottom', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingLeft() {
    return addSortByInternal('paddingLeft', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingLeftDesc() {
    return addSortByInternal('paddingLeft', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingRight() {
    return addSortByInternal('paddingRight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByPaddingRightDesc() {
    return addSortByInternal('paddingRight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingTop() {
    return addSortByInternal('paddingTop', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPaddingTopDesc() {
    return addSortByInternal('paddingTop', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPitch() {
    return addSortByInternal('pitch', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByPitchDesc() {
    return addSortByInternal('pitch', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortBySpeechRate() {
    return addSortByInternal('speechRate', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortBySpeechRateDesc() {
    return addSortByInternal('speechRate', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByTheme() {
    return addSortByInternal('theme', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByThemeDesc() {
    return addSortByInternal('theme', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByTouchLayout() {
    return addSortByInternal('touchLayout', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByTouchLayoutDesc() {
    return addSortByInternal('touchLayout', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByUseClipboard() {
    return addSortByInternal('useClipboard', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      sortByUseClipboardDesc() {
    return addSortByInternal('useClipboard', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByVolume() {
    return addSortByInternal('volume', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> sortByVolumeDesc() {
    return addSortByInternal('volume', Sort.desc);
  }
}

extension SettingIsarQueryWhereSortThenBy
    on QueryBuilder<SettingIsar, SettingIsar, QSortThenBy> {
  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByAdPosition() {
    return addSortByInternal('adPosition', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByAdPositionDesc() {
    return addSortByInternal('adPosition', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByAudioduck() {
    return addSortByInternal('audioduck', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByAudioduckDesc() {
    return addSortByInternal('audioduck', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByAudiosession() {
    return addSortByInternal('audiosession', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByAudiosessionDesc() {
    return addSortByInternal('audiosession', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByBackgroundColor() {
    return addSortByInternal('backgroundColor', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByBackgroundColorDesc() {
    return addSortByInternal('backgroundColor', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByBgFilter() {
    return addSortByInternal('bgFilter', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByBgFilterDesc() {
    return addSortByInternal('bgFilter', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByBgIdx() {
    return addSortByInternal('bgIdx', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByBgIdxDesc() {
    return addSortByInternal('bgIdx', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByCustomFont() {
    return addSortByInternal('customFont', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByCustomFontDesc() {
    return addSortByInternal('customFont', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByEnablescroll() {
    return addSortByInternal('enablescroll', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByEnablescrollDesc() {
    return addSortByInternal('enablescroll', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontColor() {
    return addSortByInternal('fontColor', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontColorDesc() {
    return addSortByInternal('fontColor', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontFamily() {
    return addSortByInternal('fontFamily', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontFamilyDesc() {
    return addSortByInternal('fontFamily', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontHeight() {
    return addSortByInternal('fontHeight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontHeightDesc() {
    return addSortByInternal('fontHeight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontSize() {
    return addSortByInternal('fontSize', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontSizeDesc() {
    return addSortByInternal('fontSize', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontWeight() {
    return addSortByInternal('fontWeight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFontWeightDesc() {
    return addSortByInternal('fontWeight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByFullScreenType() {
    return addSortByInternal('fullScreenType', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByFullScreenTypeDesc() {
    return addSortByInternal('fullScreenType', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByGroupcnt() {
    return addSortByInternal('groupcnt', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByGroupcntDesc() {
    return addSortByInternal('groupcnt', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByHeadsetbutton() {
    return addSortByInternal('headsetbutton', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByHeadsetbuttonDesc() {
    return addSortByInternal('headsetbutton', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByLast24Ad() {
    return addSortByInternal('last24Ad', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByLast24AdDesc() {
    return addSortByInternal('last24Ad', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByLastDevVersion() {
    return addSortByInternal('lastDevVersion', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByLastDevVersionDesc() {
    return addSortByInternal('lastDevVersion', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByLetterSpacing() {
    return addSortByInternal('letterSpacing', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByLetterSpacingDesc() {
    return addSortByInternal('letterSpacing', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingBottom() {
    return addSortByInternal('paddingBottom', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByPaddingBottomDesc() {
    return addSortByInternal('paddingBottom', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingLeft() {
    return addSortByInternal('paddingLeft', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingLeftDesc() {
    return addSortByInternal('paddingLeft', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingRight() {
    return addSortByInternal('paddingRight', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByPaddingRightDesc() {
    return addSortByInternal('paddingRight', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingTop() {
    return addSortByInternal('paddingTop', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPaddingTopDesc() {
    return addSortByInternal('paddingTop', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPitch() {
    return addSortByInternal('pitch', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByPitchDesc() {
    return addSortByInternal('pitch', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenBySpeechRate() {
    return addSortByInternal('speechRate', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenBySpeechRateDesc() {
    return addSortByInternal('speechRate', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByTheme() {
    return addSortByInternal('theme', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByThemeDesc() {
    return addSortByInternal('theme', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByTouchLayout() {
    return addSortByInternal('touchLayout', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByTouchLayoutDesc() {
    return addSortByInternal('touchLayout', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByUseClipboard() {
    return addSortByInternal('useClipboard', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy>
      thenByUseClipboardDesc() {
    return addSortByInternal('useClipboard', Sort.desc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByVolume() {
    return addSortByInternal('volume', Sort.asc);
  }

  QueryBuilder<SettingIsar, SettingIsar, QAfterSortBy> thenByVolumeDesc() {
    return addSortByInternal('volume', Sort.desc);
  }
}

extension SettingIsarQueryWhereDistinct
    on QueryBuilder<SettingIsar, SettingIsar, QDistinct> {
  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByAdPosition() {
    return addDistinctByInternal('adPosition');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByAudioduck() {
    return addDistinctByInternal('audioduck');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByAudiosession() {
    return addDistinctByInternal('audiosession');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct>
      distinctByBackgroundColor() {
    return addDistinctByInternal('backgroundColor');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByBgFilter() {
    return addDistinctByInternal('bgFilter');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByBgIdx() {
    return addDistinctByInternal('bgIdx');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByCustomFont(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('customFont', caseSensitive: caseSensitive);
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByEnablescroll() {
    return addDistinctByInternal('enablescroll');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFontColor() {
    return addDistinctByInternal('fontColor');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFontFamily(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fontFamily', caseSensitive: caseSensitive);
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFontHeight() {
    return addDistinctByInternal('fontHeight');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFontSize() {
    return addDistinctByInternal('fontSize');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFontWeight() {
    return addDistinctByInternal('fontWeight');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByFullScreenType() {
    return addDistinctByInternal('fullScreenType');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByGroupcnt() {
    return addDistinctByInternal('groupcnt');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByHeadsetbutton() {
    return addDistinctByInternal('headsetbutton');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByLast24Ad() {
    return addDistinctByInternal('last24Ad');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByLastDevVersion(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('lastDevVersion',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByLetterSpacing() {
    return addDistinctByInternal('letterSpacing');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByPaddingBottom() {
    return addDistinctByInternal('paddingBottom');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByPaddingLeft() {
    return addDistinctByInternal('paddingLeft');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByPaddingRight() {
    return addDistinctByInternal('paddingRight');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByPaddingTop() {
    return addDistinctByInternal('paddingTop');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByPitch() {
    return addDistinctByInternal('pitch');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctBySpeechRate() {
    return addDistinctByInternal('speechRate');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByTheme(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('theme', caseSensitive: caseSensitive);
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByTouchLayout() {
    return addDistinctByInternal('touchLayout');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByUseClipboard() {
    return addDistinctByInternal('useClipboard');
  }

  QueryBuilder<SettingIsar, SettingIsar, QDistinct> distinctByVolume() {
    return addDistinctByInternal('volume');
  }
}

extension SettingIsarQueryProperty
    on QueryBuilder<SettingIsar, SettingIsar, QQueryProperty> {
  QueryBuilder<SettingIsar, int, QQueryOperations> adPositionProperty() {
    return addPropertyNameInternal('adPosition');
  }

  QueryBuilder<SettingIsar, bool, QQueryOperations> audioduckProperty() {
    return addPropertyNameInternal('audioduck');
  }

  QueryBuilder<SettingIsar, bool, QQueryOperations> audiosessionProperty() {
    return addPropertyNameInternal('audiosession');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> backgroundColorProperty() {
    return addPropertyNameInternal('backgroundColor');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> bgFilterProperty() {
    return addPropertyNameInternal('bgFilter');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> bgIdxProperty() {
    return addPropertyNameInternal('bgIdx');
  }

  QueryBuilder<SettingIsar, String?, QQueryOperations> customFontProperty() {
    return addPropertyNameInternal('customFont');
  }

  QueryBuilder<SettingIsar, bool, QQueryOperations> enablescrollProperty() {
    return addPropertyNameInternal('enablescroll');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> fontColorProperty() {
    return addPropertyNameInternal('fontColor');
  }

  QueryBuilder<SettingIsar, String, QQueryOperations> fontFamilyProperty() {
    return addPropertyNameInternal('fontFamily');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> fontHeightProperty() {
    return addPropertyNameInternal('fontHeight');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> fontSizeProperty() {
    return addPropertyNameInternal('fontSize');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> fontWeightProperty() {
    return addPropertyNameInternal('fontWeight');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> fullScreenTypeProperty() {
    return addPropertyNameInternal('fullScreenType');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> groupcntProperty() {
    return addPropertyNameInternal('groupcnt');
  }

  QueryBuilder<SettingIsar, bool, QQueryOperations> headsetbuttonProperty() {
    return addPropertyNameInternal('headsetbutton');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<SettingIsar, DateTime, QQueryOperations> last24AdProperty() {
    return addPropertyNameInternal('last24Ad');
  }

  QueryBuilder<SettingIsar, String, QQueryOperations> lastDevVersionProperty() {
    return addPropertyNameInternal('lastDevVersion');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> letterSpacingProperty() {
    return addPropertyNameInternal('letterSpacing');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> paddingBottomProperty() {
    return addPropertyNameInternal('paddingBottom');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> paddingLeftProperty() {
    return addPropertyNameInternal('paddingLeft');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> paddingRightProperty() {
    return addPropertyNameInternal('paddingRight');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> paddingTopProperty() {
    return addPropertyNameInternal('paddingTop');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> pitchProperty() {
    return addPropertyNameInternal('pitch');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> speechRateProperty() {
    return addPropertyNameInternal('speechRate');
  }

  QueryBuilder<SettingIsar, String, QQueryOperations> themeProperty() {
    return addPropertyNameInternal('theme');
  }

  QueryBuilder<SettingIsar, int, QQueryOperations> touchLayoutProperty() {
    return addPropertyNameInternal('touchLayout');
  }

  QueryBuilder<SettingIsar, bool, QQueryOperations> useClipboardProperty() {
    return addPropertyNameInternal('useClipboard');
  }

  QueryBuilder<SettingIsar, double, QQueryOperations> volumeProperty() {
    return addPropertyNameInternal('volume');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetHistoryIsarCollection on Isar {
  IsarCollection<HistoryIsar> get historyIsars => getCollection();
}

const HistoryIsarSchema = CollectionSchema(
  name: 'HistoryIsar',
  schema:
      '{"name":"HistoryIsar","idName":"id","properties":[{"name":"cntntPstn","type":"Long"},{"name":"contentsLen","type":"Long"},{"name":"customName","type":"String"},{"name":"date","type":"Long"},{"name":"imageUri","type":"String"},{"name":"length","type":"Long"},{"name":"memo","type":"String"},{"name":"name","type":"String"},{"name":"pos","type":"Long"},{"name":"searchKeyWord","type":"String"}],"indexes":[{"name":"name","unique":true,"properties":[{"name":"name","type":"Hash","caseSensitive":true}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'cntntPstn': 0,
    'contentsLen': 1,
    'customName': 2,
    'date': 3,
    'imageUri': 4,
    'length': 5,
    'memo': 6,
    'name': 7,
    'pos': 8,
    'searchKeyWord': 9
  },
  listProperties: {},
  indexIds: {'name': 0},
  indexValueTypes: {
    'name': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _historyIsarGetId,
  setId: _historyIsarSetId,
  getLinks: _historyIsarGetLinks,
  attachLinks: _historyIsarAttachLinks,
  serializeNative: _historyIsarSerializeNative,
  deserializeNative: _historyIsarDeserializeNative,
  deserializePropNative: _historyIsarDeserializePropNative,
  serializeWeb: _historyIsarSerializeWeb,
  deserializeWeb: _historyIsarDeserializeWeb,
  deserializePropWeb: _historyIsarDeserializePropWeb,
  version: 3,
);

int? _historyIsarGetId(HistoryIsar object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _historyIsarSetId(HistoryIsar object, int id) {
  object.id = id;
}

List<IsarLinkBase> _historyIsarGetLinks(HistoryIsar object) {
  return [];
}

void _historyIsarSerializeNative(
    IsarCollection<HistoryIsar> collection,
    IsarRawObject rawObj,
    HistoryIsar object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.cntntPstn;
  final _cntntPstn = value0;
  final value1 = object.contentsLen;
  final _contentsLen = value1;
  final value2 = object.customName;
  final _customName = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_customName.length) as int;
  final value3 = object.date;
  final _date = value3;
  final value4 = object.imageUri;
  final _imageUri = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_imageUri.length) as int;
  final value5 = object.length;
  final _length = value5;
  final value6 = object.memo;
  final _memo = IsarBinaryWriter.utf8Encoder.convert(value6);
  dynamicSize += (_memo.length) as int;
  final value7 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_name.length) as int;
  final value8 = object.pos;
  final _pos = value8;
  final value9 = object.searchKeyWord;
  final _searchKeyWord = IsarBinaryWriter.utf8Encoder.convert(value9);
  dynamicSize += (_searchKeyWord.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _cntntPstn);
  writer.writeLong(offsets[1], _contentsLen);
  writer.writeBytes(offsets[2], _customName);
  writer.writeDateTime(offsets[3], _date);
  writer.writeBytes(offsets[4], _imageUri);
  writer.writeLong(offsets[5], _length);
  writer.writeBytes(offsets[6], _memo);
  writer.writeBytes(offsets[7], _name);
  writer.writeLong(offsets[8], _pos);
  writer.writeBytes(offsets[9], _searchKeyWord);
}

HistoryIsar _historyIsarDeserializeNative(
    IsarCollection<HistoryIsar> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = HistoryIsar(
    cntntPstn: reader.readLong(offsets[0]),
    contentsLen: reader.readLong(offsets[1]),
    customName: reader.readString(offsets[2]),
    date: reader.readDateTime(offsets[3]),
    imageUri: reader.readString(offsets[4]),
    length: reader.readLong(offsets[5]),
    memo: reader.readString(offsets[6]),
    name: reader.readString(offsets[7]),
    pos: reader.readLong(offsets[8]),
    searchKeyWord: reader.readString(offsets[9]),
  );
  object.id = id;
  return object;
}

P _historyIsarDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _historyIsarSerializeWeb(
    IsarCollection<HistoryIsar> collection, HistoryIsar object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'cntntPstn', object.cntntPstn);
  IsarNative.jsObjectSet(jsObj, 'contentsLen', object.contentsLen);
  IsarNative.jsObjectSet(jsObj, 'customName', object.customName);
  IsarNative.jsObjectSet(
      jsObj, 'date', object.date.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'imageUri', object.imageUri);
  IsarNative.jsObjectSet(jsObj, 'length', object.length);
  IsarNative.jsObjectSet(jsObj, 'memo', object.memo);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'pos', object.pos);
  IsarNative.jsObjectSet(jsObj, 'searchKeyWord', object.searchKeyWord);
  return jsObj;
}

HistoryIsar _historyIsarDeserializeWeb(
    IsarCollection<HistoryIsar> collection, dynamic jsObj) {
  final object = HistoryIsar(
    cntntPstn:
        IsarNative.jsObjectGet(jsObj, 'cntntPstn') ?? double.negativeInfinity,
    contentsLen:
        IsarNative.jsObjectGet(jsObj, 'contentsLen') ?? double.negativeInfinity,
    customName: IsarNative.jsObjectGet(jsObj, 'customName') ?? '',
    date: IsarNative.jsObjectGet(jsObj, 'date') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'date'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0),
    imageUri: IsarNative.jsObjectGet(jsObj, 'imageUri') ?? '',
    length: IsarNative.jsObjectGet(jsObj, 'length') ?? double.negativeInfinity,
    memo: IsarNative.jsObjectGet(jsObj, 'memo') ?? '',
    name: IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    pos: IsarNative.jsObjectGet(jsObj, 'pos') ?? double.negativeInfinity,
    searchKeyWord: IsarNative.jsObjectGet(jsObj, 'searchKeyWord') ?? '',
  );
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  return object;
}

P _historyIsarDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'cntntPstn':
      return (IsarNative.jsObjectGet(jsObj, 'cntntPstn') ??
          double.negativeInfinity) as P;
    case 'contentsLen':
      return (IsarNative.jsObjectGet(jsObj, 'contentsLen') ??
          double.negativeInfinity) as P;
    case 'customName':
      return (IsarNative.jsObjectGet(jsObj, 'customName') ?? '') as P;
    case 'date':
      return (IsarNative.jsObjectGet(jsObj, 'date') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'date'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'imageUri':
      return (IsarNative.jsObjectGet(jsObj, 'imageUri') ?? '') as P;
    case 'length':
      return (IsarNative.jsObjectGet(jsObj, 'length') ??
          double.negativeInfinity) as P;
    case 'memo':
      return (IsarNative.jsObjectGet(jsObj, 'memo') ?? '') as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'pos':
      return (IsarNative.jsObjectGet(jsObj, 'pos') ?? double.negativeInfinity)
          as P;
    case 'searchKeyWord':
      return (IsarNative.jsObjectGet(jsObj, 'searchKeyWord') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _historyIsarAttachLinks(IsarCollection col, int id, HistoryIsar object) {}

extension HistoryIsarByIndex on IsarCollection<HistoryIsar> {
  Future<HistoryIsar?> getByName(String name) {
    return getByIndex('name', [name]);
  }

  HistoryIsar? getByNameSync(String name) {
    return getByIndexSync('name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex('name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync('name', [name]);
  }

  Future<List<HistoryIsar?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex('name', values);
  }

  List<HistoryIsar?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync('name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex('name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync('name', values);
  }
}

extension HistoryIsarQueryWhereSort
    on QueryBuilder<HistoryIsar, HistoryIsar, QWhere> {
  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhere> anyName() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'name'));
  }
}

extension HistoryIsarQueryWhere
    on QueryBuilder<HistoryIsar, HistoryIsar, QWhereClause> {
  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> nameEqualTo(
      String name) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'name',
      value: [name],
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterWhereClause> nameNotEqualTo(
      String name) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'name',
        upper: [name],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'name',
        lower: [name],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'name',
        lower: [name],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'name',
        upper: [name],
        includeUpper: false,
      ));
    }
  }
}

extension HistoryIsarQueryFilter
    on QueryBuilder<HistoryIsar, HistoryIsar, QFilterCondition> {
  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      cntntPstnEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cntntPstn',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      cntntPstnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'cntntPstn',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      cntntPstnLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'cntntPstn',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      cntntPstnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'cntntPstn',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      contentsLenEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'contentsLen',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      contentsLenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'contentsLen',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      contentsLenLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'contentsLen',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      contentsLenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'contentsLen',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'customName',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'customName',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      customNameMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'customName',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'date',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'date',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'date',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'date',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> imageUriEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      imageUriGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      imageUriLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> imageUriBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'imageUri',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      imageUriStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      imageUriEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      imageUriContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'imageUri',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> imageUriMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'imageUri',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> lengthEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'length',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      lengthGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'length',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> lengthLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'length',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> lengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'length',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'memo',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'memo',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> memoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'memo',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> posEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'pos',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> posGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'pos',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> posLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'pos',
      value: value,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition> posBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'pos',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'searchKeyWord',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'searchKeyWord',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterFilterCondition>
      searchKeyWordMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'searchKeyWord',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension HistoryIsarQueryLinks
    on QueryBuilder<HistoryIsar, HistoryIsar, QFilterCondition> {}

extension HistoryIsarQueryWhereSortBy
    on QueryBuilder<HistoryIsar, HistoryIsar, QSortBy> {
  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByCntntPstn() {
    return addSortByInternal('cntntPstn', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByCntntPstnDesc() {
    return addSortByInternal('cntntPstn', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByContentsLen() {
    return addSortByInternal('contentsLen', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByContentsLenDesc() {
    return addSortByInternal('contentsLen', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByCustomName() {
    return addSortByInternal('customName', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByCustomNameDesc() {
    return addSortByInternal('customName', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByImageUri() {
    return addSortByInternal('imageUri', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByImageUriDesc() {
    return addSortByInternal('imageUri', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByLength() {
    return addSortByInternal('length', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByLengthDesc() {
    return addSortByInternal('length', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByMemo() {
    return addSortByInternal('memo', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByMemoDesc() {
    return addSortByInternal('memo', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByPos() {
    return addSortByInternal('pos', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortByPosDesc() {
    return addSortByInternal('pos', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> sortBySearchKeyWord() {
    return addSortByInternal('searchKeyWord', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy>
      sortBySearchKeyWordDesc() {
    return addSortByInternal('searchKeyWord', Sort.desc);
  }
}

extension HistoryIsarQueryWhereSortThenBy
    on QueryBuilder<HistoryIsar, HistoryIsar, QSortThenBy> {
  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByCntntPstn() {
    return addSortByInternal('cntntPstn', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByCntntPstnDesc() {
    return addSortByInternal('cntntPstn', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByContentsLen() {
    return addSortByInternal('contentsLen', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByContentsLenDesc() {
    return addSortByInternal('contentsLen', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByCustomName() {
    return addSortByInternal('customName', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByCustomNameDesc() {
    return addSortByInternal('customName', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByImageUri() {
    return addSortByInternal('imageUri', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByImageUriDesc() {
    return addSortByInternal('imageUri', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByLength() {
    return addSortByInternal('length', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByLengthDesc() {
    return addSortByInternal('length', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByMemo() {
    return addSortByInternal('memo', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByMemoDesc() {
    return addSortByInternal('memo', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByPos() {
    return addSortByInternal('pos', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenByPosDesc() {
    return addSortByInternal('pos', Sort.desc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy> thenBySearchKeyWord() {
    return addSortByInternal('searchKeyWord', Sort.asc);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QAfterSortBy>
      thenBySearchKeyWordDesc() {
    return addSortByInternal('searchKeyWord', Sort.desc);
  }
}

extension HistoryIsarQueryWhereDistinct
    on QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> {
  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByCntntPstn() {
    return addDistinctByInternal('cntntPstn');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByContentsLen() {
    return addDistinctByInternal('contentsLen');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByCustomName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('customName', caseSensitive: caseSensitive);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByDate() {
    return addDistinctByInternal('date');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByImageUri(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('imageUri', caseSensitive: caseSensitive);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByLength() {
    return addDistinctByInternal('length');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByMemo(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('memo', caseSensitive: caseSensitive);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctByPos() {
    return addDistinctByInternal('pos');
  }

  QueryBuilder<HistoryIsar, HistoryIsar, QDistinct> distinctBySearchKeyWord(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('searchKeyWord', caseSensitive: caseSensitive);
  }
}

extension HistoryIsarQueryProperty
    on QueryBuilder<HistoryIsar, HistoryIsar, QQueryProperty> {
  QueryBuilder<HistoryIsar, int, QQueryOperations> cntntPstnProperty() {
    return addPropertyNameInternal('cntntPstn');
  }

  QueryBuilder<HistoryIsar, int, QQueryOperations> contentsLenProperty() {
    return addPropertyNameInternal('contentsLen');
  }

  QueryBuilder<HistoryIsar, String, QQueryOperations> customNameProperty() {
    return addPropertyNameInternal('customName');
  }

  QueryBuilder<HistoryIsar, DateTime, QQueryOperations> dateProperty() {
    return addPropertyNameInternal('date');
  }

  QueryBuilder<HistoryIsar, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<HistoryIsar, String, QQueryOperations> imageUriProperty() {
    return addPropertyNameInternal('imageUri');
  }

  QueryBuilder<HistoryIsar, int, QQueryOperations> lengthProperty() {
    return addPropertyNameInternal('length');
  }

  QueryBuilder<HistoryIsar, String, QQueryOperations> memoProperty() {
    return addPropertyNameInternal('memo');
  }

  QueryBuilder<HistoryIsar, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<HistoryIsar, int, QQueryOperations> posProperty() {
    return addPropertyNameInternal('pos');
  }

  QueryBuilder<HistoryIsar, String, QQueryOperations> searchKeyWordProperty() {
    return addPropertyNameInternal('searchKeyWord');
  }
}
