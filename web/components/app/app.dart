library app;

import 'package:angular2/angular2.dart';
import '../../services/note_store.dart' show Store, Note, NoteFactory;
import '../card/card.dart';

@Component(selector: 'app', appInjector: const [Store, NoteFactory])
@View(
    templateUrl: 'components/app/app.html',
    directives: const [NgFor, formDirectives, Card])
class AppComponent {
  Store noteStore;
  Note selectedNote = null;
  NoteFactory noteFactory;

  String newTitle;
  String newContent;

  bool showAll = false;

  bool ignoreSelection = false;

  AppComponent(this.noteStore, this.noteFactory);

  enterNote() {
    _addNote(newTitle, newContent);
    newTitle = "";
    newContent = "";
    showAll = false;
  }

  selectNote(Note note) {
    if (ignoreSelection) {
      ignoreSelection = false;
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
      ignoreSelection = true;
    }
  }

  _addNote(String title, String content) {
    noteStore.add(noteFactory.create(title, content));
  }

  deleteMe(Note note) {
    clearSelection(true);
    noteStore.remove(note);
  }
}
