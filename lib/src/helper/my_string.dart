library bedb.helper.table_names;

extension MyString on String {
  static String getTableName(String i) => i + 's';

  static String getObjName(String i) {
    String e = i[0].toUpperCase();
    e += i.substring(1);
    return e;
  }

  String firstUpper() {
    String e = this[0].toUpperCase();
    e += substring(1);
    return e;
  }
}
