library todo_store;

class KeyModel {
  int key;
  KeyModel(this.key);
}

class Todo extends KeyModel {
  String title;
  String content;
  bool completed;

  Todo(int key, this.title, this.content, this.completed) : super(key);
}

class TodoFactory {
  num uid = 1;

  nextUid() {
    this.uid = this.uid + 1;
  }

  create(String title, String content, bool complete) {
    return new Todo(nextUid(), title, content, complete);
  }
}

class Store {
  List<KeyModel> list = [new Todo(0, "Add moar tasks!", "", false)];

  add(KeyModel record) {
    list.insert(0, record);
  }

  remove(KeyModel record) {
    list.remove(record);
  }

  removeBy(Function callback) {
    list.removeWhere(callback);
  }
}
