import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.orange,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initialiazeFlutterFire() async {}

  List todos = List();
  String input = "";

  createTodos() {
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        FirebaseFirestore.instance.collection("MyTodos").document(input);
    Map<String, String> todos = {"todoTitle": input};
    // ignore: deprecated_member_use
    documentReference.setData(todos).whenComplete(() {
      print("$input created");
    });
  }

  // @override
  // void initState() {
  //   initialiazeFlutterFire();
  //   super.initState();
  // }

  deleteTodos() {}

  @override
  void initState() {
    super.initState();
    todos.add("Item 1");
    todos.add("Item 2");
    todos.add("Item 3");
    todos.add("Item 4");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add Todo List"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createTodos();
                          Navigator.of(context).pop();
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("MyTodos").snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Dismissible(
                      key: Key(index.toString()),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(documentSnapshot["todoTitle"]),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  todos.removeAt(index);
                                });
                              }),
                        ),
                      ));
                });
          }),
    );
  }
}
