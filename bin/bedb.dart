import 'dart:convert';
import 'dart:io';

import 'package:bedb/src/sqlite/builder.dart' as sqlite;

Future<void> main(List<String> arguments) async {
  final File file = File('./bedb.json');
  final Map doc = jsonDecode(file.readAsStringSync());

  // final Map? config = doc['config'];
  // if (config == null) {
  // throw "You must add config label";
  // }

  // if (config['db'] == SupportedDB.sqlite) {
  await sqlite.build(doc);
  Process.runSync("dart", ["format", "."]);
  // }
}
