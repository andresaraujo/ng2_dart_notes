library app;

import 'package:angular2/angular2.dart';
import 'package:ng2_dart_notes/services/note_store.dart' show Store, Note, NoteFactory;
import 'package:ng2_dart_notes/components/card/card.dart';

@Component(selector: 'app', viewBindings: const [Store, NoteFactory])
@View(
    templateUrl: 'package:ng2_dart_notes/app.html',
    directives: const [NgFor, FORM_DIRECTIVES, Card])
class AppComponent {
  Store noteStore;
  Note selectedNote = null;
  NoteFactory _noteFactory;

  String newTitle;
  String newContent;

  bool showAll = false;

  bool _ignoreSelection = false;

  AppComponent(this.noteStore, this._noteFactory);

  enterNote() {
    _addNote(newTitle, newContent);
    newTitle = "";
    newContent = "";
    showAll = false;
  }

  selectNote(Note note) {
    if (_ignoreSelection) {
      _ignoreSelection = false;
      return;
    }
    this.selectedNote = note;
  }

  doneEditing(Map noteChanges, Note note) {
    note.title = noteChanges['title'];
    note.content = noteChanges['content'];
    //noteStore.save(note);
    clearSelection(true);
  }

  clearSelection([bool preventSelection = false]) {
    selectedNote = null;
    if (preventSelection) {
      _ignoreSelection = true;
    }
  }

  _addNote(String title, String content) {
    noteStore.add(_noteFactory.create(title, content));
  }

  deleteMe(Note note) {
    clearSelection(true);
    noteStore.remove(note);
  }
}