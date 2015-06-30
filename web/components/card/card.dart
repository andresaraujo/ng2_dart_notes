import 'dart:html' as html;
import 'package:angular2/angular2.dart';

@Component(
    selector: "notes-card",
    events: const [
  "onSave: onsave",
  "onDelete: ondelete",
  "onCancel: oncancel"
],
    properties: const ["title", "content", "edit"],
    host: const {'(body:^keydown)': 'documentOnKeyPress(\$event)'})
@View(
    directives: const [formDirectives],
    templateUrl: "components/card/card.html")
class Card {
  String _title;
  String _content;

  String newTitle;
  String newContent;
  bool edit = false;

  EventEmitter onSave = new EventEmitter();
  EventEmitter onDelete = new EventEmitter();
  EventEmitter onCancel = new EventEmitter();

  set title(title) {
    _title = title;
    newTitle = title;
  }
  set content(content) {
    _content = content;
    newContent = content;
  }
  get title => _title;
  get content => _content;

  save() {
    onSave.add({"title": newTitle, "content": newContent});
  }

  delete() {
    onDelete.add(null);
  }

  documentOnKeyPress(event) {
    if (event.keyCode == html.KeyCode.ESC) {
      newContent = _content;
      newTitle = _title;
      onCancel.add(null);
    }
  }
}
