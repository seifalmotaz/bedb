// int8, int4, int3, int2, int1
import 'field_types.dart';

class Int4Type extends FieldType {
  final String name;
  const Int4Type(this.name, super.ref);

  @override
  String get sql => 'INTEGER';
  @override
  String get dart => 'int';

  static Int4Type get<T>(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return Int4Type(fieldName, ref);
  }
}

class Int8Type extends Int4Type {
  const Int8Type(super.name, super.ref);

  @override
  String get sql => 'BIGINT';

  static Int8Type get(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return Int8Type(fieldName, ref);
  }
}

class Int2Type extends Int4Type {
  const Int2Type(super.name, super.ref);

  @override
  String get sql => 'SMALLINT';

  static Int2Type get(String fieldName, Map data) {
    TableRef? ref;
    if (data['ref'] != null) {
      ref = TableRef(data['ref']['table'], data['ref']['field']);
    }
    return Int2Type(fieldName, ref);
  }
}
