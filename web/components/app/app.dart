library app;

import 'package:angular2/angular2.dart';
import '../../services/todo_store.dart' show Store, Todo, TodoFactory;
import 'dart:html';

@Component(selector: 'app', appInjector: const [Store, TodoFactory])
@View(templateUrl: 'components/app/app.html', directives: const [NgFor, formDirectives])
class AppComponent {
  Store todoStore;
  Todo todoEdit = null;
  TodoFactory todoFactory;

  String newTitle;
  String newContent;

  bool showAll = false;

  AppComponent(this.todoStore, this.todoFactory);

  enterTodo(KeyboardEvent event, ngElement) {
    InputElement input = (ngElement as InputElement);
    if (event.which == 13) {
      this.addTodo(input.value, "");
      input.value = "";
    }
  }

  xTodo() {
    this.addTodo(newTitle, newContent);
    newTitle = "";
    newContent = "";
    showAll = false;
  }

  editTodo(Todo todo) {
    this.todoEdit = todo;
  }

  doneEditing(Todo todo) {
    //todoStore.save(todo);
    todoEdit = null;
  }

  addTodo(String title, String content) {
    todoStore.add(todoFactory.create(title, content, false));
  }

  completeMe(Todo todo) {
    todo.completed = !todo.completed;
  }

  deleteMe(Todo todo) {
    todoStore.remove(todo);
  }

  toggleAll(event) {
    var isComplete = event.target.checked;

    todoStore.list.forEach((Todo todo) {
      todo.completed = isComplete;
      //todoStore.save(todo);
    });
  }

  clearCompleted() {
    todoStore.removeBy((Todo todo) => todo.completed);
  }

  yyy() {
    //showAll = true;
    print("wwwwwwwwwww");
  }
}
