import 'dart:convert';

import 'package:todonew/Const/const.dart';
import 'package:todonew/Helpers/storage_helper.dart';
import 'package:todonew/Models/todo.dart';

class ToDoController {
  final st = StorageHelper();

  Future<bool> create(ToDoModel data) async {
    try {
      var todos = await getAll();
      todos[data.id.toString()] = data;

      await writeData(todos);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> update(ToDoModel todo) {
    return create(todo);
  }

  Future<ToDoModel?> read(String id) async {
    try {
      var todos = await getAll();
      return todos[id];
    } catch (e) {
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      var todos = await getAll();
      todos.remove(id);
      await writeData(todos);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> writeData(Map<String, ToDoModel> todos) async {
    var newData = <String, dynamic>{};
    todos.forEach((key, value) {
      newData[key] = value.toJson();
    });

    await st.write("todos", jsonEncode(newData));
  }

  Future<void> changeStatus(ToDoModel item) async {
    var todos = await getAll();

    if (item.status == Status.success.name) {
      todos[item.id.toString()]?.status = Status.pending.name;
    } else {
      todos[item.id.toString()]?.status = Status.success.name;
    }

    await writeData(todos);
  }

  Future<Map<String, ToDoModel>> getAll() async {
    try {
      String? todos = await st.read("todos");
      if (todos == null) {
        return {};
      }

      Map<String, ToDoModel> data = {};

      (jsonDecode(todos) as Map).forEach((key, value) {
        data[key] = ToDoModel.fromJson(value);
      });

      return data;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }
}
