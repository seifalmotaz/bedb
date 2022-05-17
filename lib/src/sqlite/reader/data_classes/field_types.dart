import 'package:bedb/src/sqlite/builder.dart';

import 'data_classes.dart';
import 'int_types.dart';

class TableRef {
  final String table;
  final String field;
  TableRef(this.table, this.field);
}

abstract class FieldType {
  String get sql;
  String get dart;
  final TableRef? ref;
  const FieldType(this.ref);

  TableDB get tableRef => tables.firstWhere((e) => e.name == ref!.table);

  static Map<String, FieldType Function(String, Map)> types = {
    /// string types
    "varchar": VarcharType.get,
    "text": TextType.get,
    // integer types
    "int": Int4Type.get, // int
    "int2": Int2Type.get, // small int
    "int4": Int4Type.get, // int
    "int8": Int8Type.get, // big int
    // other
    "bool": BoolType.get,
  };

  /// `f` stands for `field`
  static FieldType get(String fname, Map data) {
    String ftype = data['type'] ?? (throw "Unknown type for $fname");
    return (types[ftype] ?? (throw "Type not supported"))(fname, data);
  }
}

class VarcharType extends FieldType {
  final String name;
  final int len;
  const VarcharType(this.name, this.len, super.ref);

  @override
  String get sql => 'VARCHAR($len)';
  @override
  String get dart => 'String';

  static VarcharType get(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return VarcharType(fieldName, data['length'] ?? 255, ref);
  }
}

class TextType extends FieldType {
  final String name;
  const TextType(this.name, super.ref);

  @override
  String get sql => 'TEXT';
  @override
  String get dart => 'String';

  static TextType get(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return TextType(fieldName, ref);
  }
}

class BoolType extends FieldType {
  final String name;
  const BoolType(this.name, super.ref);

  @override
  String get sql => 'BOOLEAN';
  @override
  String get dart => 'bool';

  static BoolType get(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return BoolType(fieldName, ref);
  }
}
