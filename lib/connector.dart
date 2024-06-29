class Connector {
  static int editMode = -1;
  static String data = "";

  static int fetchEditMode() {
    return editMode;
  }

  static setEditMode(int value) {
    editMode = value;
  }

  static setData(String value) {
    data = value;
  }

  static String fetchData() {
    return data;
  }
}
