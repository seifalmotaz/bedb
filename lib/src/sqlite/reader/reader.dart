import 'package:bedb/src/sqlite/reader/data_classes/field_types.dart';
import 'package:bedb/src/sqlite/reader/data_classes/data_classes.dart';

List<TableDB> read(Map map) {
  final List<TableDB> tables = [];
  for (var model in map.entries) {
    final TableDB t = TableDB(model.key);
    for (var field in model.value.entries) {
      final Map value = field.value;
      t.fields.add(FieldDB(
        field.key,
        FieldType.get(field.key, value),
        isOptional: value['optional'] ?? false,
        isPK: value['pk'] ?? false,
        isAI: value['ai'] ?? false,
      ));
    }
    tables.add(t);
  }

  return tables;
}
