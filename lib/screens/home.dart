import "package:flutter/material.dart";
import "../constraints/Colors.dart";
import "../models/todo.dart";
import "../widgets/todo_item.dart";

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: const Text(
                            "All ToDos",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todoo in todosList)
                          ToDoItem(
                            todo: todoo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          ),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                        hintText: "Add a new todo Item",
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      addToDoItem(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {});
    todosList.removeWhere((item) => item.id == id);
  }

  void addToDoItem(String toDo) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    todoController.clear();
  }

  Widget searchBox() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: const TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: "Search",
          ),
        ),
      )
    ]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0, //shadow will disappear
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // making the pic circular
            child: Image.asset("assets/images/5967119.png"),
          ),
        )
      ]),
    );
  }
}
