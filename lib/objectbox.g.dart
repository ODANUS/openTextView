// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/box_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5860126872655072353),
      name: 'HistoryBox',
      lastPropertyId: const IdUid(12, 1911845170971597191),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 352521872285546636),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(3, 2826976511782243153),
            name: 'pos',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 132717871986977989),
            name: 'length',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5034273627586168018),
            name: 'name',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 5750636096342618128)),
        ModelProperty(
            id: const IdUid(7, 6477180265705262401),
            name: 'customName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 8982687513807118933),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 1129873602505652676),
            name: 'imageUri',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 690511540553708050),
            name: 'contentsLen',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 1911845170971597191),
            name: 'memo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 3953390841151068515),
      name: 'FilterBox',
      lastPropertyId: const IdUid(6, 8706714152138801238),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4592607484312071879),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3186745347348454945),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8306087208509615325),
            name: 'expr',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6924846675314704374),
            name: 'filter',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7136727973666677559),
            name: 'to',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8706714152138801238),
            name: 'enable',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1885558662605261282),
      name: 'SettingBox',
      lastPropertyId: const IdUid(14, 1463864747235604102),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6566781617567910213),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5143228194294400785),
            name: 'fontSize',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5311924569092078238),
            name: 'fontWeight',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1258546732810483298),
            name: 'fontFamily',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 6655142748906001023),
            name: 'fontHeight',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7340052858266409398),
            name: 'speechRate',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1632507722343512474),
            name: 'volume',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 7822695320103906492),
            name: 'pitch',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5160550212494429626),
            name: 'groupcnt',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 7778627177872900413),
            name: 'touchLayout',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7178390294196630270),
            name: 'useClipboard',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 7813530482419901276),
            name: 'headsetbutton',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 897118049981345923),
            name: 'audiosession',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 1463864747235604102),
            name: 'theme',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 1885558662605261282),
      lastIndexId: const IdUid(1, 5750636096342618128),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1743096673413393534,
        3488698397340737493,
        1698622970140566567
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    HistoryBox: EntityDefinition<HistoryBox>(
        model: _entities[0],
        toOneRelations: (HistoryBox object) => [],
        toManyRelations: (HistoryBox object) => {},
        getId: (HistoryBox object) => object.id,
        setId: (HistoryBox object, int id) {
          object.id = id;
        },
        objectToFB: (HistoryBox object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final customNameOffset = fbb.writeString(object.customName);
          final imageUriOffset = fbb.writeString(object.imageUri);
          final memoOffset = fbb.writeString(object.memo);
          fbb.startTable(13);
          fbb.addInt64(0, object.id);
          fbb.addInt64(2, object.pos);
          fbb.addInt64(3, object.length);
          fbb.addOffset(4, nameOffset);
          fbb.addOffset(6, customNameOffset);
          fbb.addInt64(8, object.date.millisecondsSinceEpoch);
          fbb.addOffset(9, imageUriOffset);
          fbb.addInt64(10, object.contentsLen);
          fbb.addOffset(11, memoOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = HistoryBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              date: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0)),
              pos: const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              length:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
              customName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 16, ''),
              imageUri:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 22, ''),
              contentsLen:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 24, 0),
              memo: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 26, ''));

          return object;
        }),
    FilterBox: EntityDefinition<FilterBox>(
        model: _entities[1],
        toOneRelations: (FilterBox object) => [],
        toManyRelations: (FilterBox object) => {},
        getId: (FilterBox object) => object.id,
        setId: (FilterBox object, int id) {
          object.id = id;
        },
        objectToFB: (FilterBox object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final filterOffset = fbb.writeString(object.filter);
          final toOffset = fbb.writeString(object.to);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addBool(2, object.expr);
          fbb.addOffset(3, filterOffset);
          fbb.addOffset(4, toOffset);
          fbb.addBool(5, object.enable);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FilterBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              filter:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              to: const fb.StringReader().vTableGet(buffer, rootOffset, 12, ''),
              expr:
                  const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false),
              enable: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 14, false));

          return object;
        }),
    SettingBox: EntityDefinition<SettingBox>(
        model: _entities[2],
        toOneRelations: (SettingBox object) => [],
        toManyRelations: (SettingBox object) => {},
        getId: (SettingBox object) => object.id,
        setId: (SettingBox object, int id) {
          object.id = id;
        },
        objectToFB: (SettingBox object, fb.Builder fbb) {
          final fontFamilyOffset = fbb.writeString(object.fontFamily);
          final themeOffset = fbb.writeString(object.theme);
          fbb.startTable(15);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.fontSize);
          fbb.addInt64(2, object.fontWeight);
          fbb.addOffset(3, fontFamilyOffset);
          fbb.addFloat64(4, object.fontHeight);
          fbb.addFloat64(5, object.speechRate);
          fbb.addFloat64(6, object.volume);
          fbb.addFloat64(7, object.pitch);
          fbb.addInt64(8, object.groupcnt);
          fbb.addInt64(9, object.touchLayout);
          fbb.addBool(10, object.useClipboard);
          fbb.addBool(11, object.headsetbutton);
          fbb.addBool(12, object.audiosession);
          fbb.addOffset(13, themeOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = SettingBox(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              fontSize:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              fontWeight:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              fontFamily:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''),
              fontHeight:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0),
              speechRate:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0),
              volume:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 16, 0),
              pitch:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 18, 0),
              groupcnt:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0),
              headsetbutton: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 26, false),
              audiosession: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 28, false),
              touchLayout:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 22, 0),
              useClipboard: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 24, false),
              theme: const fb.StringReader()
                  .vTableGet(buffer, rootOffset, 30, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [HistoryBox] entity fields to define ObjectBox queries.
class HistoryBox_ {
  /// see [HistoryBox.id]
  static final id =
      QueryIntegerProperty<HistoryBox>(_entities[0].properties[0]);

  /// see [HistoryBox.pos]
  static final pos =
      QueryIntegerProperty<HistoryBox>(_entities[0].properties[1]);

  /// see [HistoryBox.length]
  static final length =
      QueryIntegerProperty<HistoryBox>(_entities[0].properties[2]);

  /// see [HistoryBox.name]
  static final name =
      QueryStringProperty<HistoryBox>(_entities[0].properties[3]);

  /// see [HistoryBox.customName]
  static final customName =
      QueryStringProperty<HistoryBox>(_entities[0].properties[4]);

  /// see [HistoryBox.date]
  static final date =
      QueryIntegerProperty<HistoryBox>(_entities[0].properties[5]);

  /// see [HistoryBox.imageUri]
  static final imageUri =
      QueryStringProperty<HistoryBox>(_entities[0].properties[6]);

  /// see [HistoryBox.contentsLen]
  static final contentsLen =
      QueryIntegerProperty<HistoryBox>(_entities[0].properties[7]);

  /// see [HistoryBox.memo]
  static final memo =
      QueryStringProperty<HistoryBox>(_entities[0].properties[8]);
}

/// [FilterBox] entity fields to define ObjectBox queries.
class FilterBox_ {
  /// see [FilterBox.id]
  static final id = QueryIntegerProperty<FilterBox>(_entities[1].properties[0]);

  /// see [FilterBox.name]
  static final name =
      QueryStringProperty<FilterBox>(_entities[1].properties[1]);

  /// see [FilterBox.expr]
  static final expr =
      QueryBooleanProperty<FilterBox>(_entities[1].properties[2]);

  /// see [FilterBox.filter]
  static final filter =
      QueryStringProperty<FilterBox>(_entities[1].properties[3]);

  /// see [FilterBox.to]
  static final to = QueryStringProperty<FilterBox>(_entities[1].properties[4]);

  /// see [FilterBox.enable]
  static final enable =
      QueryBooleanProperty<FilterBox>(_entities[1].properties[5]);
}

/// [SettingBox] entity fields to define ObjectBox queries.
class SettingBox_ {
  /// see [SettingBox.id]
  static final id =
      QueryIntegerProperty<SettingBox>(_entities[2].properties[0]);

  /// see [SettingBox.fontSize]
  static final fontSize =
      QueryIntegerProperty<SettingBox>(_entities[2].properties[1]);

  /// see [SettingBox.fontWeight]
  static final fontWeight =
      QueryIntegerProperty<SettingBox>(_entities[2].properties[2]);

  /// see [SettingBox.fontFamily]
  static final fontFamily =
      QueryStringProperty<SettingBox>(_entities[2].properties[3]);

  /// see [SettingBox.fontHeight]
  static final fontHeight =
      QueryDoubleProperty<SettingBox>(_entities[2].properties[4]);

  /// see [SettingBox.speechRate]
  static final speechRate =
      QueryDoubleProperty<SettingBox>(_entities[2].properties[5]);

  /// see [SettingBox.volume]
  static final volume =
      QueryDoubleProperty<SettingBox>(_entities[2].properties[6]);

  /// see [SettingBox.pitch]
  static final pitch =
      QueryDoubleProperty<SettingBox>(_entities[2].properties[7]);

  /// see [SettingBox.groupcnt]
  static final groupcnt =
      QueryIntegerProperty<SettingBox>(_entities[2].properties[8]);

  /// see [SettingBox.touchLayout]
  static final touchLayout =
      QueryIntegerProperty<SettingBox>(_entities[2].properties[9]);

  /// see [SettingBox.useClipboard]
  static final useClipboard =
      QueryBooleanProperty<SettingBox>(_entities[2].properties[10]);

  /// see [SettingBox.headsetbutton]
  static final headsetbutton =
      QueryBooleanProperty<SettingBox>(_entities[2].properties[11]);

  /// see [SettingBox.audiosession]
  static final audiosession =
      QueryBooleanProperty<SettingBox>(_entities[2].properties[12]);

  /// see [SettingBox.theme]
  static final theme =
      QueryStringProperty<SettingBox>(_entities[2].properties[13]);
}
