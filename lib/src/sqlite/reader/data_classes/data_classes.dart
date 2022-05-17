import 'package:bedb/src/helper/my_string.dart';
import 'package:bedb/src/sqlite/reader/data_classes/field_types.dart';

class TableDB {
  final String name;
  final List<FieldDB> fields = [];
  TableDB(this.name);

  String get objName => MyString.getObjName(name);
  String get tableName => MyString.getTableName(name);

  FieldDB operator [](String i) => fields.firstWhere(
        (e) => e.name == i,
        orElse: () => throw "Unknow field $i in table $name",
      );
}

class FieldDB {
  final String name;
  final FieldType type;

  // options fields
  final bool isOptional;
  final bool isPK;
  final bool isAI;
  final dynamic defaultValue;

  // init
  const FieldDB(
    this.name,
    this.type, {
    this.isOptional = false,
    this.defaultValue,
    this.isPK = false,
    this.isAI = false,
  });
}
