import 'dart:html' as html;

import 'package:angular2/angular2.dart';

@Component(
    selector: "notes-card",
    host: const {'(body:^keydown)': 'documentOnKeyPress(\$event)'})
@View(
    directives: const [FORM_DIRECTIVES],
    templateUrl: "package:ng2_dart_notes/components/card/card.html")
class Card {
  String _title;
  String _content;

  String newTitle;
  String newContent;
  @Input() bool edit = false;

  @Output() EventEmitter onSave = new EventEmitter();
  @Output() EventEmitter onDelete = new EventEmitter();
  @Output() EventEmitter onCancel = new EventEmitter();

  get content => _content;

  @Input()
  set content(content) {
    _content = content;
    newContent = content;
  }

  get title => _title;

  @Input()
  set title(title) {
    _title = title;
    newTitle = title;
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

  save() {
    onSave.add({"title": newTitle, "content": newContent});
  }
}
