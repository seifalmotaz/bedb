import 'dart:io';

import 'package:bedb/src/helper/my_file.dart';
import 'package:bedb/src/sqlite/builder.dart';
import 'package:bedb/src/sqlite/reader/data_classes/data_classes.dart';

/// compile tables data to sql schema
Future<void> compile() async {
  StringBuffer buffer = StringBuffer();
  for (var table in tables) {
    List<String> refs = [];
    buffer.writeln("DROP TABLE IF EXISTS ${table.tableName};");
    buffer.writeln("CREATE TABLE ${table.tableName} ("); // start create query
    for (var i = 0; i < table.fields.length; i++) {
      FieldDB field = table.fields[i];

      String sql = '  ${field.name} ${field.type.sql}';
      if (!field.isOptional) sql += " NOT NULL";
      if (field.isPK) sql += " PRIMARY KEY";
      if (field.isAI) sql += " AUTOINCREMENT";
      if (i != table.fields.length - 1 || refs.isNotEmpty) sql += ",";
      buffer.writeln(sql);

      if (field.type.ref != null) {
        TableDB tableRef = field.type.tableRef;
        refs.add("CONSTRAINT ${field.name}_ref "
            "FOREIGN KEY(${field.name})"
            " REFERENCES ${tableRef.tableName}(${tableRef[field.type.ref!.field].name})");
      }
    }
    for (var i = 0; i < refs.length; i++) {
      String sql = "  ${refs[i]}";
      if (i != refs.length - 1) sql += ",";
      buffer.writeln(sql);
    }
    buffer.writeln(");"); // end create query
    buffer.writeln(""); // tables query seperator
  }
  File file = MyFile.create("./bedb/sql/main.sql");
  await file.writeAsString(buffer.toString());
}
