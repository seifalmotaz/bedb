extension MyList on List {
  lastv([Object? v]) {
    try {
      return last;
    } on StateError {
      return v;
    }
  }

  firstv([Object? v]) {
    try {
      return first;
    } on StateError {
      return v;
    }
  }
}
