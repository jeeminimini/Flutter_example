import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';
import 'addTodo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>DatabaseApp(database),
        '/add':(context)=>AddTodoApp(database),
      },
     // home: DatabaseApp(),
    );
  }

  Future<Database> initDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(),'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, content TEXT, active INTEGER)",
        );
      },
    version:1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  DatabaseApp(this.db);

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp>{
  Future<List<Todo>>? todoList;


  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database Example'),),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState){
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData){
                    return ListView.builder(itemBuilder: (context, index) {
                      Todo todo = (snapshot.data as List<Todo>)[index];
                      return ListTile(
                        title: Text(
                          todo.title!,
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Container(
                          child: Column(
                            children: <Widget>[
                              Text(todo.content!),
                              Text('?????? : ${todo.active == 1? 'true':'false'}'),
                              Container(
                                height: 1,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        onTap: () async{
                          TextEditingController controller = new TextEditingController(text:todo.content);
                          Todo result = await showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('${todo.id} : ${todo.title}'),
                              content: TextField(
                                controller: controller,
                                keyboardType: TextInputType.text,
                              ),
                              actions: <Widget>[
                                TextButton(onPressed: (){
                                  todo.active == 1 ? todo.active=0 : todo.active=1;
                                  todo.content =controller.value.text;
                                  Navigator.of(context).pop(todo);
                                }, child: Text('???')),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop(todo);
                                }, child: Text('?????????')),
                              ],
                            );
                          });
                          _updateTodo(result);
                        },
                        onLongPress: () async{
                          Todo result = await showDialog(context: context, builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('${todo.id}:${todo.title}'),
                              content: Text('${todo.content}??? ?????????????????????????'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop(todo);
                                  },
                                  child: Text('???')),
                                TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('?????????')),
                              ],
                            );
                          });
                          _deleteTodo(result);
                        },
                      );
                    },
                    itemCount: (snapshot.data as List<Todo>).length,);
                  } else{
                    return Text('No data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: todoList,
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final todo = await Navigator.of(context).pushNamed('/add');
          if(todo!=null){
            _insetTodo(todo as Todo);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _deleteTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.delete('todos',where: 'id=?',whereArgs: [todo.id]);
    setState(() {
      todoList=getTodos();
    });
  }

  void _updateTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.update('todos', todo.toMap(),where: 'id=?',whereArgs:[todo.id],);
    setState(() {
      todoList = getTodos();
    });
  }

  void _insetTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.insert('todos',todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async{
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (i){
      int active = maps[i]['active'] == 1?1:0;
      return Todo(
        title: maps[i]['title'].toString(),
        content: maps[i]['content'].toString(),
        active: active,
        id: maps[i]['id']);
    });
  }

}
