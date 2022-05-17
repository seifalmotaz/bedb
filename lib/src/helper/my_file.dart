import 'dart:io';
import 'package:path/path.dart' as p;

extension MyFile on File {
  static File create(String path) {
    String fileName = p.basename(path);
    String dirPath = p.dirname(path);

    Directory d = Directory(dirPath);
    if (!d.existsSync()) d.createSync(recursive: true);

    File file = File(p.join(dirPath, fileName));
    if (!file.existsSync()) file.createSync();

    return file;
  }
}
