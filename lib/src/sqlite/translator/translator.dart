import 'dart:io';

import 'package:bedb/src/helper/my_file.dart';
import 'package:bedb/src/sqlite/builder.dart';
import 'package:bedb/src/sqlite/reader/data_classes/data_classes.dart';

import 'basic.dart';

Future<void> translate() async {
  await basic();
  for (var table in tables) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln("part of '../main.dart';");
    classGen(table, buffer);
    File file =
        MyFile.create('./bedb/models/${table.objName.toLowerCase()}.dart');
    await file.writeAsString(buffer.toString());
  }
}

void classGen(TableDB table, StringBuffer buffer) {
  buffer.writeln("class ${table.objName} {"); // starting class
  for (final FieldDB field in table.fields) {
    buffer.writeln("late final ${field.type.dart} ${field.name};");
  }
  buffer.writeln("");
  for (final FieldDB field in table.fields) {
    if (field.type.ref != null) {
      TableDB tableRef = field.type.tableRef;
      buffer.writeln("// ${tableRef.objName} get${tableRef.objName}() {");
      buffer.writeln("// get the user");
      buffer.writeln("// }");
    }
  }

  buffer.writeln("}"); // ending class
}
