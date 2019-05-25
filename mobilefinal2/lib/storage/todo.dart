import 'package:sqflite/sqflite.dart';

final String todoTable = "todo";
final String columnId = "id";
final String columnUserid = "userid";
final String columnName = "name";
final String columnAge = "age";
final String columnPassword = "password";

class Todo {
  int id;
  String userid;
  String name;
  String age;
  String password;

  Todo();

  Todo.formMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.userid = map[columnUserid];
    this.name = map[columnName];
    this.age = map[columnAge];
    this.password = map[columnPassword];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnUserid: userid,
      columnName: name,
      columnAge: age,
      columnPassword: password,
    };
    if (id != null) {
      map[columnId] = id; 
    }
    return map;
  }

  @override
  String toString() { return 'id: ${this.id}, userid:  ${this.userid}, name:  ${this.name}, age:  ${this.age}, password:  ${this.password}'; }

}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      create table $todoTable (
        $columnId integer primary key autoincrement,
        $columnUserid text not null unique,
        $columnName text not null,
        $columnAge number not null,
        $columnPassword text not null
      )
      ''');
    });
  }

  Future<Todo> insertUser(Todo user) async {
    user.id = await db.insert(todoTable, user.toMap());
    return user;
  }

  Future<List<Todo>> getAllUser() async {
    await this.open("todo");
    var all = await db.query(todoTable, columns: [columnId, columnUserid, columnName, columnAge, columnPassword]);
    List<Todo> userList = all.isNotEmpty ? all.map((c) => Todo.formMap(c)).toList() : [];
    return userList;
  }

  Future close() async => db.close();

}