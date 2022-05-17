library bedb.sqlite;

import 'reader/reader.dart' as reader;
import 'compiler/compiler.dart' as compiler;
import 'translator/translator.dart' as translator;
import 'reader/data_classes/data_classes.dart';

late final List<TableDB> tables;

Future<void> build(Map doc) async {
  tables = reader.read(doc['models']);
  await compiler.compile();
  await translator.translate();
}
