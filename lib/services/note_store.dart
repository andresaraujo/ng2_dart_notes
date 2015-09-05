library todo_store;

import 'package:angular2/di.dart' show Injectable;


class KeyModel {
  int key;
  KeyModel(this.key);
}

class Note extends KeyModel {
  String title;
  String content;

  Note(int key, this.title, this.content) : super(key);

  toString() => "{'title': $title, 'content': $content}";
}

@Injectable()
class NoteFactory {
  num uid = 1;

  nextUid() {
    this.uid = this.uid + 1;
  }

  create(String title, String content) {
    return new Note(nextUid(), title, content);
  }
}

@Injectable()
class Store {
  List<KeyModel> list = [new Note(0, "Add moar tasks!", "")];

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
