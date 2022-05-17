import 'dart:io';

import 'package:bedb/src/helper/my_file.dart';
import 'package:bedb/src/helper/my_string.dart';
import 'package:bedb/src/sqlite/builder.dart';

Future<void> basic() async {
  StringBuffer buffer = StringBuffer(); // init file content

  buffer.write("""
import "dart:io";

import 'package:path/path.dart' as p;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
""");

  // adding the file parts
  {
    buffer.writeln("");
    for (var table in tables) {
      buffer.writeln("part './models/${table.objName.toLowerCase()}.dart';");
    }
  }
  buffer.writeln("class BeDB {"); // starting bedb class

  // add the table classes
  {
    buffer.writeln("final Database cursor;");
    buffer.writeln("BeDB(this.cursor);");
    buffer.writeln("");
    for (var table in tables) {
      buffer.writeln("// late final ${table.tableName.firstUpper()}"
          " ${table.tableName};");
    }
  }

  buffer.writeln("");
  // writing the init method
  buffer.write("""
  static Future<void> createSchema(Database db, int version) async {}
  
  static Future<void> initdb() async {
  sqfliteFfiInit();
  Directory dbFolder = Directory("./");
  File dir = File(p.join(dbFolder.path, 'database.sqlite3'));
  DatabaseFactory sFactory = databaseFactoryFfi;
  var connect = await sFactory.openDatabase(
    dir.path,
    options: OpenDatabaseOptions(
      onCreate: createSchema,
      readOnly: false,
      version: 1,
      // onUpgrade: upgradeSchema,
    ),
  );
  }
  """);

  buffer.writeln("}"); // ending bedb class

  File mainFile = MyFile.create("./bedb/main.dart");
  await mainFile.writeAsString(buffer.toString());
}
