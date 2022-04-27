import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/models/todomodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allTodos = Provider.of<TodoModel>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: ElevatedButton.icon(
            onPressed: null,
            icon: Icon(Icons.countertops),
            label: Text("Total = ${allTodos.items.length}")),
        title: const Text("Todo App "),
        centerTitle: true,
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are You Sure?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              allTodos.clearTodo();
                              Navigator.pop(context);
                            },
                            child: Text("Confirm")),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"))
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.delete),
              label: Text("Clear")),
        ],
      ),
      body: allTodos.items.length == 0
          ? Center(
              child: Container(
                child: Text(
                  "No Todo Found",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : ListView.builder(
              itemCount: allTodos.items.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: allTodos.items[i].isImportant
                      ? GestureDetector(
                          onTap: () {
                            allTodos.changeImportant(i);
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.favorite,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            allTodos.changeImportant(i);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.favorite_outline_rounded,
                            ),
                          ),
                        ),
                  title: Text(allTodos.items[i].title),
                  subtitle: Text(allTodos.items[i].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20.0,
                          color: Colors.brown[900],
                        ),
                        onPressed: () {
                          
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20.0,
                          color: Colors.brown[900],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Are You Sure?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        allTodos.deleteTodo(i);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Confirm")),
                                  OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"))
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showAlertDialog(context);
          }),
    );
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  final allTodos = Provider.of<TodoModel>(context, listen: false);
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add Todo"),
    content: Container(
      width: double.maxFinite,
      height: 200,
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.name,
            maxLines: null,
            controller: cTitle,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            keyboardType: TextInputType.name,
            maxLines: null,
            controller: cDesc,
            decoration: InputDecoration(labelText: "Description"),
          ),
        ],
      ),
    ),
    actions: [
      ElevatedButton(
          onPressed: () {
            allTodos.addTodo(Todo(
                id: Random().nextInt(1000000),
                title: cTitle.text,
                description: cDesc.text,
                isImportant: true));
            Navigator.pop(context);
          },
          child: Text("Save")),
      OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"))
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
